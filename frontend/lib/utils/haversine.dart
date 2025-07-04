import '../models/unit.dart';
import '../services/map_service.dart';

List<UnitModel> filterUnitsByDistance(
  List<UnitModel> units, 
  double userLat, 
  double userLng, 
  double radiusKm
) {
  return units.where((unit) {
    double distance = LocationService().calculateDistance(userLat, userLng, unit.latitude, unit.longitude);
    return distance <= radiusKm;
  }).toList();
}