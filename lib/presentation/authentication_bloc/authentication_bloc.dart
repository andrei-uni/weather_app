import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/authentication/authentication_status.dart';
import 'package:weather_app/domain/usecases/authentication/auth_status_stream_usecase.dart';
import 'package:weather_app/domain/usecases/authentication/log_out_usecase.dart';
import 'package:weather_app/utils/locator.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(Unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<Unauthenticate>(_onUnauthenticate);

    _authenticationStatusSubscription = _authStatusStreamUsecase().listen((status) {
      add(_AuthenticationStatusChanged(authenticationStatus: status));
    });
  }

  late final StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  final _logOutUsecase = locator<LogOutUsecase>();
  final _authStatusStreamUsecase = locator<AuthStatusStreamUsecase>();

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {
    switch (event.authenticationStatus) {
      case AuthenticationStatus.authenticated:
        emit(Authenticated());
      case AuthenticationStatus.unauthenticated:
        emit(Unauthenticated());
    }
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthenticationState> emit) {
    _logOutUsecase();
  }

  @override
  Future<void> close() async {
    await _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
