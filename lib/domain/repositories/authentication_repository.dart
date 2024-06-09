import 'package:weather_app/domain/models/authentication_status.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get authenticationStatusStream;

  void checkAuthenticationStatus();

  Future<void> logIn({
    required String token,
  });

  Future<void> logOut();
}