import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/authentication/log_in_usecase.dart';
import 'package:weather_app/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:weather_app/utils/app_router/app_router.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/locator.dart';

@RoutePage()
class AuthenticationScreen extends StatelessWidget implements AutoRouteWrapper {
  AuthenticationScreen({super.key});

  // for now there's no state in this screen 
  // so we can do without bloc

  final _keyController = TextEditingController(
    text: Constants.mockApiKey, // hardcoded for illustration purposes
  );

  final _logInUsecase = locator<LogInUsecase>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.router.replaceAll([CurrentWeatherRoute()]);
        }
      },
      child: this,
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
              TextField(
                controller: _keyController,
                decoration: const InputDecoration(
                  hintText: 'Key',
                  border: OutlineInputBorder(),
                ),
                autocorrect: false,
                enableSuggestions: false,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _confirmPressed,
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

  void _confirmPressed() async {
    final key = _keyController.text.trim();

    if (key.isEmpty) {
      return;
    }

    await _logInUsecase(apiKey: key);
  }
}
