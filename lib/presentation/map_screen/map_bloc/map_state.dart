part of 'map_bloc.dart';

final class MapState {
  MapState({
    required this.mapController,
    required this.selectedLocation,
    required this.confirmingCoordinates,
    required this.messageToShow,
  });

  final MapController mapController;
  final Location? selectedLocation;
  final bool confirmingCoordinates;
  final String? messageToShow;

  MapState copyWith({
    MapController? mapController,
    Location? selectedLocation,
    bool? confirmingCoordinates,
    ValueGetter<String?>? messageToShow,
  }) {
    return MapState(
      mapController: mapController ?? this.mapController,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      confirmingCoordinates: confirmingCoordinates ?? this.confirmingCoordinates,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
    );
  }
}
