import 'package:location/location.dart';
import 'dart:math';

class LocationService {
  final Location _location = Location();

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
    }

    if (permissionGranted == PermissionStatus.granted) {
      return await _location.getLocation();
    }
    throw Exception("Izin lokasi ditolak");
  }

  // Hitung jarak dengan Haversine
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
            cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // Jarak dalam km
  }
}