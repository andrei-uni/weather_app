import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/usecases/local_locations/add_location_usecase.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/locator.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(MapState(
          mapController: MapController(
            initPosition: GeoPoint(
              latitude: Constants.initialLocation.coordinates.latitude,
              longitude: Constants.initialLocation.coordinates.longitude,
            ),
          ),
          selectedLocation: null,
          confirmingCoordinates: false,
          messageToShow: null,
        )) {
    on<UseMyLocation>(_onUseMyLocation);
    on<ConfirmLocation>(_onConfirmLocation);
  }

  final _addLocationUsecase = locator<AddLocationUsecase>();

  void _onUseMyLocation(UseMyLocation event, Emitter<MapState> emit) async {
    final locationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!locationEnabled) {
      _showMessage('Please enable geolocation', emit);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showMessage('Location permissions are denied', emit);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showMessage('Please enable geolocation for this app', emit);
      return;
    }

    final Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    await state.mapController.moveTo(GeoPoint(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    ));
  }

  void _onConfirmLocation(ConfirmLocation event, Emitter<MapState> emit) async {
    emit(state.copyWith(confirmingCoordinates: true));

    final GeoPoint mapCenter = await state.mapController.centerMap;

    final coordinates = Coordinates(
      latitude: mapCenter.latitude,
      longitude: mapCenter.longitude,
    );

    final Location? location = await _addLocationUsecase(coordinates);

    if (location == null) {
      emit(state.copyWith(confirmingCoordinates: false));
      _showMessage('Your location is invalid, please select a new one', emit);
      return;
    }

    emit(state.copyWith(selectedLocation: location));
  }

  void _showMessage(String message, Emitter<MapState> emit) {
    emit(state.copyWith(messageToShow: () => message));
    emit(state.copyWith(messageToShow: () => null));
  }

  @override
  Future<void> close() {
    state.mapController.dispose();
    return super.close();
  }
}
