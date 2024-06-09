part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class _CheckAuthentication extends AuthenticationEvent {}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  _AuthenticationStatusChanged({
    required this.authenticationStatus,
  });

  final AuthenticationStatus authenticationStatus;
}

final class Unauthenticate extends AuthenticationEvent {}
