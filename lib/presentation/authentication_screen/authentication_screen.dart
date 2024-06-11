import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/authentication_screen/authentication_screen_bloc/authentication_screen_bloc.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthenticationScreenBloc(),
        child: Scaffold(
          body: BlocBuilder<AuthenticationScreenBloc, AuthenticationScreenState>(
            builder: (context, state) {
              return Padding(
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
                      controller: state.keyController,
                      decoration: const InputDecoration(
                        hintText: 'Key',
                        border: OutlineInputBorder(),
                      ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
