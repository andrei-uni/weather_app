class LatitudeLongitude {
  LatitudeLongitude({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  // Converts this object to a queryParameter
  // Name of the method is required by Retrofit
  String toJson() => '$latitude,$longitude';
}
