import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/domain/models/authentication/authentication_status.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';
import 'package:weather_app/utils/locator.dart';
import 'package:weather_app/utils/secure_storage_keys.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl() {
    _checkAuthenticationStatus();
  }

  final _secureStorage = locator<FlutterSecureStorage>();

  final _authenticationStatusController = StreamController<AuthenticationStatus>();

  void _checkAuthenticationStatus() async {
    final apiKey = await _secureStorage.read(key: SecureStorageKeys.weatherApiKey);

    if (apiKey == null) {
      _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
    } else {
      _authenticationStatusController.add(AuthenticationStatus.authenticated);
    }
  }

  @override
  Stream<AuthenticationStatus> get authenticationStatusStream async* {
    yield* _authenticationStatusController.stream;
  }

  @override
  Future<void> logIn({required String apiKey}) async {
    await _secureStorage.write(key: SecureStorageKeys.weatherApiKey, value: apiKey);
    _authenticationStatusController.add(AuthenticationStatus.authenticated);
  }

  @override
  Future<void> logOut() async {
    await _secureStorage.deleteAll();
    _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
  }
}
