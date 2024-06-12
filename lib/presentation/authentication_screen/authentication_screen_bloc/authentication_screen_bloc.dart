import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/domain/repositories/local_coordinates_repository.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/locator.dart';

part 'authentication_screen_event.dart';
part 'authentication_screen_state.dart';

class AuthenticationScreenBloc extends Bloc<AuthenticationScreenEvent, AuthenticationScreenState> {
  AuthenticationScreenBloc()
      : super(AuthenticationScreenState(
          keyController: TextEditingController(
            text: Constants.mockApiKey, // hardcoded for illustration purposes
          ),
        )) {
    on<ConfirmApiKey>(_onConfirmApiKey);
  }

  final _authenticationRepository = locator<AuthenticationRepository>();
  final _localCoordinatesRepository = locator<LocalCoordinatesRepository>();

  void _onConfirmApiKey(ConfirmApiKey event, Emitter<AuthenticationScreenState> emit) async {
    if (state.keyController.text.trim().isEmpty) {
      return;
    }

    await _localCoordinatesRepository.addCoordinates(Constants.initialCoordinates);

    await _authenticationRepository.logIn(apiKey: state.keyController.text.trim());
  }
}
