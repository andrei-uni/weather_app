import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/usecases/authentication/log_in_usecase.dart';
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

  final _logInUsecase = locator<LogInUsecase>();

  void _onConfirmApiKey(ConfirmApiKey event, Emitter<AuthenticationScreenState> emit) async {
    final key = state.keyController.text.trim();

    if (key.isEmpty) {
      return;
    }

    _logInUsecase(apiKey: key);
  }

  @override
  Future<void> close() {
    state.keyController.dispose();
    return super.close();
  }
}
