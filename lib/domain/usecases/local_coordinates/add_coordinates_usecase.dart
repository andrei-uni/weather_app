import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/locator.dart';

class AddCoordinatesUsecase {
  final _localCoordinatesRepository = locator<LocalCoordinatesRepository>();

  Future<void> call(Coordinates coordinates) async {
    await _localCoordinatesRepository.addCoordinates(coordinates);
  }
}
