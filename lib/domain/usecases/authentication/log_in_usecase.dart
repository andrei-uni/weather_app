import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/locator.dart';

class LogInUsecase {
  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localCoordinatesRepository = locator<LocalCoordinatesRepository>();

  void call({required String apiKey}) async {
    await _localCoordinatesRepository.addCoordinates(Constants.initialCoordinates);
    await _authenticationRepository.logIn(apiKey: apiKey);
  }
}
