import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/unit.dart';

Marker createUnitMarker(UnitModel unit) {
  return Marker(
    markerId: MarkerId(unit.name),
    position: LatLng(unit.latitude, unit.longitude),
    infoWindow: InfoWindow(
      title: unit.name,
      snippet: "Status: ${unit.status}",
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      unit.status == "Siaga" 
        ? BitmapDescriptor.hueGreen 
        : BitmapDescriptor.hueOrange,
    ),
  );
}