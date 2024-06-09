import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repositories/authentication_repository_impl.dart';
import 'package:weather_app/domain/models/authentication_status.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';

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

  final AuthenticationRepository _authenticationRepository = AuthenticationRepositoryImpl();

  void _onCheckAuthentication(_CheckAuthentication event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.checkAuthenticationStatus();
  }

  void _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {
    switch (event.authenticationStatus) {
      case AuthenticationStatus.authenticated:
        emit(Autheticated());
      case AuthenticationStatus.unauthenticated:
        emit(Unautheticated());
    }
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) async {
    //TODO
    await _authenticationRepository.logOut();
  }

  @override
  Future<void> close() async {
    await _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
