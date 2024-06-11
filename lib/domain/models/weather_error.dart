sealed class WeatherError {}

final class NoConnection extends WeatherError {}

final class InvalidLocation extends WeatherError {}

final class InvalidKey extends WeatherError {}

final class KeyQuotaExceeded extends WeatherError {}

final class InternalServerError extends WeatherError {}

final class UnknownError extends WeatherError {
  UnknownError({
    required this.message,
  });

  final String message;
}
