part of 'map_bloc.dart';

final class MapState {
  MapState({
    required this.mapController,
    required this.messageToShow,
  });

  final MapController mapController;
  final String? messageToShow;

  MapState copyWith({
    MapController? mapController,
    ValueGetter<String?>? messageToShow,
  }) {
    return MapState(
      mapController: mapController ?? this.mapController,
      messageToShow: messageToShow != null ? messageToShow() : this.messageToShow,
    );
  }
}
