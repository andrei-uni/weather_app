import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_locations_repository.dart';
import 'package:weather_app/utils/locator.dart';

class LogOutUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localLocationsRepository = locator<LocalLocationsRepository>();

  Future<void> call() async {
    await _authenticationRepository.logOut();
    await _localLocationsRepository.deleteAllData();
  }
}
