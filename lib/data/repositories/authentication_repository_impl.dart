import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/domain/models/authentication_status.dart';
import 'package:weather_app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  final _secureStorage = const FlutterSecureStorage();

  final _token = 'token';

  final _authenticationStatusController = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get authenticationStatusStream async* {
    yield* _authenticationStatusController.stream;
  }

  @override
  void checkAuthenticationStatus() async {
    final token = await _secureStorage.read(key: _token);

    if (token == null) {
      _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
    } else {
      _authenticationStatusController.add(AuthenticationStatus.authenticated);
    }
  }

  @override
  Future<void> logIn({required String token}) async {
    await _secureStorage.write(key: _token, value: token);
    _authenticationStatusController.add(AuthenticationStatus.authenticated);
  }

  @override
  Future<void> logOut() async {
    await _secureStorage.delete(key: _token);
    _authenticationStatusController.add(AuthenticationStatus.unauthenticated);
  }
}
