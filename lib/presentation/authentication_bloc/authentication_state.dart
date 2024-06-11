part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class Authenticated extends AuthenticationState {
  Authenticated({
    required this.coordinates,
  });

  final Coordinates coordinates;
}

final class Unauthenticated extends AuthenticationState {}

final class Unknown extends AuthenticationState {}
