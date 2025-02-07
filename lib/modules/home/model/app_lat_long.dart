class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class MetroLocation extends AppLatLong {
  const MetroLocation({
    super.lat = 41.326928,
    super.long = 69.327526,
  });
}
