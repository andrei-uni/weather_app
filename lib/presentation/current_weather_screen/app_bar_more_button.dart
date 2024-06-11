import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/presentation/map_screen/map_screen.dart';

class AppBarMoreButton extends StatelessWidget {
  const AppBarMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SubmenuButton(
      menuChildren: [
        MenuItemButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const MapScreen();
              }),
            );
          },
          child: const Text('Change Location'),
        ),
        MenuItemButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(Unauthenticate());
          },
          child: const Text('Log Out'),
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        size: 30,
      ),
    );
  }
}
