import 'package:weather_app/domain/models/authentication/authentication_status.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get authenticationStatusStream;

  Future<void> logIn({
    required String apiKey,
  });

  Future<void> logOut();
}
