import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/locator.dart';

class GetCoordinatesUsecase {
  final _localCoordinatesRepository = locator<LocalCoordinatesRepository>();

  Future<Coordinates?> call() async {
    return await _localCoordinatesRepository.getCoordinates();
  }
}
