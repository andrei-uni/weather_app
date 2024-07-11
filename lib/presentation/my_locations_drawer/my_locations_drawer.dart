import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/my_locations_drawer/my_locations_bloc/my_locations_bloc.dart';
import 'package:weather_app/presentation/my_locations_drawer/location_item_widget.dart';

class MyLocationsDrawer extends StatelessWidget {
  const MyLocationsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleMedium;
    return BlocProvider(
      create: (context) => MyLocationsBloc(),
      child: Drawer(
        child: BlocBuilder<MyLocationsBloc, MyLocationsState>(
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Default Location',
                    style: titleTextStyle,
                  ),
                ),
                LocationItemWidget(
                  location: state.defaultLocation,
                  showMenuButton: false,
                  onDelete: (_) {},
                  onSetDefault: (_) {},
                ),
                if (state.otherLocations.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'My Locations',
                      style: titleTextStyle,
                    ),
                  ),
                for (final location in state.otherLocations)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: LocationItemWidget(
                      location: location,
                      showMenuButton: true,
                      onDelete: (location) {
                        context.read<MyLocationsBloc>().add(DeleteLocation(location));
                      },
                      onSetDefault: (location) {
                        context.read<MyLocationsBloc>().add(SetDefaultLocation(location));
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
