import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/authentication_status.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/locator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unknown()) {
    on<_CheckAuthentication>(_onCheckAuthentication);
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<Unauthenticate>(_onUnauthenticate);

    _authenticationStatusSubscription = _authenticationRepository.authenticationStatusStream.listen((status) {
      add(_AuthenticationStatusChanged(authenticationStatus: status));
    });

    add(_CheckAuthentication());
  }

  late final StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localCoordinatesRepository = locator<LocalCoordinatesRepository>();

  void _onCheckAuthentication(_CheckAuthentication event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.checkAuthenticationStatus();
  }

  void _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) async {
    switch (event.authenticationStatus) {
      case AuthenticationStatus.authenticated:
        final coordinates = await _localCoordinatesRepository.getCoordinates();
        emit(Authenticated(coordinates: coordinates!));

      case AuthenticationStatus.unauthenticated:
        emit(Unauthenticated());
    }
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) async {
    await _authenticationRepository.logOut();
    await _localCoordinatesRepository.deleteAllData();
  }

  @override
  Future<void> close() async {
    await _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
