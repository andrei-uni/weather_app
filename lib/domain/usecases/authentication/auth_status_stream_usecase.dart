import 'package:weather_app/domain/models/authentication_status.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/utils/locator.dart';

class AuthStatusStreamUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();

  Stream<AuthenticationStatus> call() async* {
    yield* _authenticationRepository.authenticationStatusStream;
  }
}
