import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/utils/app_router/app_router.dart';
import 'package:weather_app/utils/gradients.dart';

class LocationItemWidget extends StatelessWidget {
  const LocationItemWidget({
    super.key,
    required this.location,
    required this.showMenuButton,
    required this.onDelete,
    required this.onSetDefault,
  });

  final Location location;
  final bool showMenuButton;
  final void Function(Location) onDelete;
  final void Function(Location) onSetDefault;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.pushAndPopUntil(
          CurrentWeatherRoute(location: location),
          predicate: (route) => false,
        );
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 35),
            decoration: BoxDecoration(
              gradient: Gradients.locationItemGradient(context),
            ),
            child: Text(
              location.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.grey.shade300,
                  ),
            ),
          ),
          if (showMenuButton)
            Padding(
              padding: const EdgeInsets.all(8),
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () => onSetDefault(location),
                      child: const Text('Set Default'),
                    ),
                    PopupMenuItem(
                      onTap: () => onDelete(location),
                      child: const Text('Delete'),
                    ),
                  ];
                },
                child: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
