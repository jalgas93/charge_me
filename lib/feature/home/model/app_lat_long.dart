class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class AlmataLocation extends AppLatLong {
  const AlmataLocation({
    super.lat = 43.161200,
    super.long = 76.540000,
  });
}
class TashkentLocation extends AppLatLong {
  const TashkentLocation({
    super.lat = 41.2646,
    super.long = 60.1258,
  });
}

