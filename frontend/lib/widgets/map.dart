// lib/widgets/map_widget.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../services/map_service.dart';

class MapWidget extends StatefulWidget {
  final bool showUserMarker;
  const MapWidget({super.key, this.showUserMarker = true});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  late LocationData currentUserLocation;

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
      
      // Marker pengguna
      if (widget.showUserMarker) {
        _markers.add(
          Marker(
            markerId: MarkerId("user"),
            position: LatLng(currentUserLocation.latitude!, currentUserLocation.longitude!),
            infoWindow: InfoWindow(title: "Lokasi Anda"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: currentUserLocation.latitude != null && currentUserLocation.longitude != null
          ? GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(currentUserLocation.latitude!, currentUserLocation.longitude!),
                      zoom: 15,
                    ),
                  ),
                );
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(currentUserLocation.latitude ?? 0, currentUserLocation.longitude ?? 0),
                zoom: 15,
              ),
              markers: _markers,
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}