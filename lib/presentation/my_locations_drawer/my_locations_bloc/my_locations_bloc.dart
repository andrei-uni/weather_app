import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/domain/usecases/local_locations/change_default_location_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/delete_location_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/get_all_locations_usecase.dart';
import 'package:weather_app/domain/usecases/local_locations/get_default_location_usecase.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/locator.dart';

part 'my_locations_event.dart';
part 'my_locations_state.dart';

class MyLocationsBloc extends Bloc<MyLocationsEvent, MyLocationsState> {
  MyLocationsBloc()
      : super(MyLocationsState(
          defaultLocation: Constants.initialLocation,
          otherLocations: [],
        )) {
    on<_LoadLocations>(_onLoadLocations);
    on<DeleteLocation>(_onDeleteLocation);
    on<SetDefaultLocation>(_onSetDefaultLocation);

    add(_LoadLocations());
  }

  final _getAllLocationsUsecase = locator<GetAllLocationsUsecase>();
  final _getDefaultLocationUsecase = locator<GetDefaultLocationUsecase>();
  final _deleteLocationUsecase = locator<DeleteLocationUsecase>();
  final _changeDefaultLocationUsecase = locator<ChangeDefaultLocationUsecase>();

  void _onLoadLocations(_LoadLocations event, Emitter<MyLocationsState> emit) async {
    final (List<Location> locations, Location defaultLocation) = await (
      _getAllLocationsUsecase(),
      _getDefaultLocationUsecase(),
    ).wait;

    emit(MyLocationsState(
      defaultLocation: defaultLocation,
      otherLocations: locations..removeWhere((e) => e.id == defaultLocation.id),
    ));
  }

  void _onDeleteLocation(DeleteLocation event, Emitter<MyLocationsState> emit) async {
    final Location location = event.location;

    emit(state.copyWith(
      otherLocations: state.otherLocations..remove(location),
    ));

    await _deleteLocationUsecase(location);
  }

  void _onSetDefaultLocation(SetDefaultLocation event, Emitter<MyLocationsState> emit) async {
    final Location newDefaultLocation = event.location;

    await _changeDefaultLocationUsecase(newDefaultLocation);

    add(_LoadLocations());
  }
}
