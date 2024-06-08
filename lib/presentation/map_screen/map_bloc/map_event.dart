part of 'map_bloc.dart';

sealed class MapEvent {}

final class UseMyLocation extends MapEvent {}

final class ConfirmLocation extends MapEvent {}
