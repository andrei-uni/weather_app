import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoggedInWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const LoggedInWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
