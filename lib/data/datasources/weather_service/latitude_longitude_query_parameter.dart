class LatitudeLongitudeQueryParameter {
  LatitudeLongitudeQueryParameter({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  // Converts this object to a query parameter
  // Name of the method is required by Retrofit
  String toJson() => '$latitude,$longitude';
}
