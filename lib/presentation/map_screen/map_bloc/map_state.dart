part of 'map_bloc.dart';

final class MapState {
  MapState({
    required this.mapController,
    required this.messageToShow,
    required this.hasSelectedCoordinates,
  });

  final MapController mapController;
  final String? messageToShow;
  final bool hasSelectedCoordinates;

  MapState copyWith({
    MapController? mapController,
    ValueGetter<String?>? messageToShow,
    bool? hasSelectedCoordinates,
  }) {
    return MapState(
      mapController: mapController ?? this.mapController,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
      hasSelectedCoordinates: hasSelectedCoordinates ?? this.hasSelectedCoordinates,
    );
  }
}
