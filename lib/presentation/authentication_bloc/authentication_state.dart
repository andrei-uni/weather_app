part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class Autheticated extends AuthenticationState {}

final class Unautheticated extends AuthenticationState {}

final class Unknown extends AuthenticationState {}
