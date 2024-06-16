import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/locator.dart';

class LogOutUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localCoordinatesRepository = locator<LocalCoordinatesRepository>();

  void call() async {
    await _authenticationRepository.logOut();
    await _localCoordinatesRepository.deleteAllData();
  }
}
