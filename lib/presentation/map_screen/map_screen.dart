import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:weather_app/presentation/current_weather_screen/current_weather_screen.dart';
import 'package:weather_app/presentation/map_screen/map_bloc/map_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Select Location'),
            centerTitle: true,
            actions: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () => context.read<MapBloc>().add(ConfirmLocation()),
                  icon: const Icon(Icons.check),
                );
              }),
            ],
          ),
          floatingActionButton: Builder(builder: (context) {
            return FloatingActionButton(
              onPressed: () => context.read<MapBloc>().add(UseMyLocation()),
              child: const Icon(Icons.my_location),
            );
          }),
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
                ],
              );
            },
          ),
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

    if (state.selectedCoordinates != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return CurrentWeatherScreen(coordinates: state.selectedCoordinates!);
        }),
        (route) => false,
      );
    }
  }
}
