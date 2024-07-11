part of 'my_locations_bloc.dart';

sealed class MyLocationsEvent {}

final class _LoadLocations extends MyLocationsEvent {}

final class DeleteLocation extends MyLocationsEvent {
  DeleteLocation(this.location);

  final Location location;
}

final class SetDefaultLocation extends MyLocationsEvent {
  SetDefaultLocation(this.location);

  final Location location;
}
