import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:weather_app/presentation/map_screen/map_bloc/map_bloc.dart';
import 'package:weather_app/utils/app_router/app_router.dart';

@RoutePage()
class MapScreen extends StatelessWidget implements AutoRouteWrapper {
  const MapScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Location'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => context.read<MapBloc>().add(ConfirmLocation()),
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<MapBloc>().add(UseMyLocation()),
          child: const Icon(Icons.my_location),
        ),
        body: BlocConsumer<MapBloc, MapState>(
          listener: stateChanged,
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                OSMFlutter(
                  controller: state.mapController,
                  osmOption: const OSMOption(
                    enableRotationByGesture: false,
                    zoomOption: ZoomOption(
                      initZoom: 11,
                    ),
                  ),
                ),
                const IgnorePointer(
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                if (state.confirmingCoordinates)
                  Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                if (state.confirmingCoordinates)
                  const SizedBox.square(
                    dimension: 60,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 8,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void stateChanged(BuildContext context, MapState state) {
    if (state.messageToShow != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(state.messageToShow!)),
        );
    }

    if (state.selectedLocation != null) {
      context.router.replaceAll(
        [CurrentWeatherRoute(location: state.selectedLocation!)],
        updateExistingRoutes: false,
      );
    }
  }
}
