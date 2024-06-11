part of 'map_bloc.dart';

final class MapState {
  MapState({
    required this.mapController,
    required this.messageToShow,
    required this.selectedCoordinates,
  });

  final MapController mapController;
  final String? messageToShow;
  final Coordinates? selectedCoordinates;

  MapState copyWith({
    MapController? mapController,
    ValueGetter<String?>? messageToShow,
    Coordinates? selectedCoordinates,
  }) {
    return MapState(
      mapController: mapController ?? this.mapController,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
      selectedCoordinates: selectedCoordinates ?? this.selectedCoordinates,
    );
  }
}
