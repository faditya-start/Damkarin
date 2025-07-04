import 'dart:math';
import '../models/unit.dart';

List<UnitModel> filterUnitsByDistance(
  List<UnitModel> units, 
  double userLat, 
  double userLng, 
  double radiusKm
) {
  return units.where((unit) {
    double distance = calculateDistance(userLat, userLng, unit.latitude, unit.longitude);
    return distance <= radiusKm;
  }).toList();
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 - cos((lat2 - lat1) * p)/2 +
          cos(lat1 * p) * cos(lat2 * p) *
          (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a)); 
}