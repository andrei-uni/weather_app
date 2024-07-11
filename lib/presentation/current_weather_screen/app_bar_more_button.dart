import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/utils/app_router/app_router.dart';

class AppBarMoreButton extends StatelessWidget {
  const AppBarMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                context.router.push(const MapRoute());
              },
              child: const Text('Add Location'),
            ),
            PopupMenuItem(
              onTap: () {
                context.read<AuthenticationBloc>().add(Unauthenticate());
                context.router.replaceAll([AuthenticationRoute()]);
              },
              child: const Text('Log Out'),
            ),
          ];
        },
        child: const Icon(
          Icons.more_vert,
          size: 30,
        ),
      ),
    );
  }
}
