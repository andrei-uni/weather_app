import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/presentation/authentication_screen/authentication_screen_bloc/authentication_screen_bloc.dart';
import 'package:weather_app/utils/app_router/app_router.dart';

@RoutePage()
class AuthenticationScreen extends StatelessWidget implements AutoRouteWrapper {
  const AuthenticationScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationScreenBloc(),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.router.replaceAll([CurrentWeatherRoute()]);
          }
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                'Please enter your weatherapi.com key',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Spacer(),
              BlocBuilder<AuthenticationScreenBloc, AuthenticationScreenState>(
                builder: (context, state) {
                  return TextField(
                    controller: state.keyController,
                    decoration: const InputDecoration(
                      hintText: 'Key',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.read<AuthenticationScreenBloc>().add(ConfirmApiKey());
                  },
                  child: const Text('Confirm'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
