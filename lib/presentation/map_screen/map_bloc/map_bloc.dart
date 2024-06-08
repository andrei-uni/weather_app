import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(MapState(
          mapController: MapController(
            initPosition: GeoPoint(latitude: 55.7558, longitude: 37.6172), // Moscow
          ),
          messageToShow: null,
        )) {
    on<UseMyLocation>(_onUseMyLocation);
    on<ConfirmLocation>(_onConfirmLocation);
  }

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

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    await state.mapController.moveTo(GeoPoint(
      latitude: position.latitude,
      longitude: position.longitude,
    ));
  }

  void _onConfirmLocation(ConfirmLocation event, Emitter<MapState> emit) async {
    final GeoPoint location = await state.mapController.centerMap;
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
