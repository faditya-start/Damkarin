import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../services/map_service.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  TrackingScreenState createState() => TrackingScreenState();
}

class TrackingScreenState extends State<TrackingScreen> {
  late GoogleMapController mapController;
  late LocationData currentUserLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      currentUserLocation = await LocationService().getCurrentLocation();
      _updateMarkers();
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  void _updateMarkers() {
    setState(() {
      _markers.clear();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Tracking")),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(currentUserLocation.latitude!, currentUserLocation.longitude!),
              zoom: 15,
            ),
          ));
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 1,
        ),
        markers: _markers,
      ),
    );
  }
}