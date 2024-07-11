part of 'my_locations_bloc.dart';

final class MyLocationsState {
  MyLocationsState({
    required this.defaultLocation,
    required this.otherLocations,
  });

  final Location defaultLocation;
  final List<Location> otherLocations;

  MyLocationsState copyWith({
    Location? defaultLocation,
    List<Location>? otherLocations,
  }) {
    return MyLocationsState(
      defaultLocation: defaultLocation ?? this.defaultLocation,
      otherLocations: otherLocations ?? this.otherLocations,
    );
  }
}
