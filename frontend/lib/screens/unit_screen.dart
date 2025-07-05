import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:math';
import '../utils/custom_marker.dart';

class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  LocationData? currentLocation;
  GoogleMapController? mapController;
  Map<String, dynamic>? nearestDamkar;
  Timer? _timer;
  double _angle = 0.0;
  final double _radius = 0.001; // ~100m
  Map<String, LatLng> unitPositions = {}; // key: unitId, value: LatLng
  Map<String, BitmapDescriptor> unitIcons = {};

  // Data pos damkar dengan unit berbeda-beda
  final List<Map<String, dynamic>> damkarLocations = [
    {
      'name': 'Pos Damkar Papanggo',
      'lat': -6.1234,
      'lng': 106.8765,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Papanggo, Tanjung Priok',
      'phone': '021-6543211',
      'units': [
        {
          'name': 'Fire Truck',
          'image': 'assets/images/fire_truck.png',
          'status': 'Siaga',
          'jumlah': 2,
        },
        {
          'name': 'Water Tanker',
          'image': 'assets/images/water_tanker.png',
          'status': 'Dalam perbaikan',
          'jumlah': 1,
        },
      ],
    },
    {
      'name': 'Pos Damkar Podomoro',
      'lat': -6.1345,
      'lng': 106.8876,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Sunter Agung, Tanjung Priok',
      'phone': '021-6543212',
      'units': [
        {
          'name': 'Fire Truck',
          'image': 'assets/images/fire_truck.png',
          'status': 'Siaga',
          'jumlah': 1,
        },
        {
          'name': 'Rescue Car',
          'image': 'assets/images/rescue_car.png',
          'status': 'Melakukan tugas',
          'jumlah': 1,
        },
      ],
    },
    {
      'name': 'Pos Damkar Gaya Motor',
      'lat': -6.1456,
      'lng': 106.8987,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Sungai Bambu, Tanjung Priok',
      'phone': '021-6543213',
      'units': [
        {
          'name': 'Fire Truck',
          'image': 'assets/images/fire_truck.png',
          'status': 'Dalam perbaikan',
          'jumlah': 1,
        },
        {
          'name': 'Water Tanker',
          'image': 'assets/images/water_tanker.png',
          'status': 'Siaga',
          'jumlah': 2,
        },
      ],
    },
    {
      'name': 'Pos Damkar Walikota',
      'lat': -6.1567,
      'lng': 106.9098,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Kebon Bawang, Tanjung Priok',
      'phone': '021-6543214',
      'units': [
        {
          'name': 'Rescue Car',
          'image': 'assets/images/rescue_car.png',
          'status': 'Siaga',
          'jumlah': 2,
        },
      ],
    },
    {
      'name': 'Pos Damkar Danau Sunter',
      'lat': -6.1678,
      'lng': 106.9209,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Sunter Jaya, Tanjung Priok',
      'phone': '021-6543215',
      'units': [
        {
          'name': 'Fire Truck',
          'image': 'assets/images/fire_truck.png',
          'status': 'Siaga',
          'jumlah': 1,
        },
        {
          'name': 'Water Tanker',
          'image': 'assets/images/water_tanker.png',
          'status': 'Siaga',
          'jumlah': 1,
        },
        {
          'name': 'Rescue Car',
          'image': 'assets/images/rescue_car.png',
          'status': 'Dalam perbaikan',
          'jumlah': 1,
        },
      ],
    },
    // Tambah pos lain jika perlu
  ];

  @override
  void initState() {
    super.initState();
    _initLocation();
    _initUnitIcons();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initLocation() async {
    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
    final loc = await location.getLocation();
    setState(() {
      currentLocation = loc;
      nearestDamkar = _findNearestDamkar(loc.latitude!, loc.longitude!);
    });
  }

  Future<void> _initUnitIcons() async {
    // Create custom circular icons for each unit type
    final fireTruckIcon = await CustomMarker.createCircularMarker(
      backgroundColor: Colors.red,
      imagePath: 'assets/images/fire_truck.png',
    );
    final waterTankerIcon = await CustomMarker.createCircularMarker(
      backgroundColor: Colors.blue,
      imagePath: 'assets/images/water_tanker.png',
    );
    final rescueCarIcon = await CustomMarker.createCircularMarker(
      backgroundColor: Colors.orange,
      imagePath: 'assets/images/rescue_car.png',
    );
    
    unitIcons = {
      'Fire Truck': fireTruckIcon,
      'Water Tanker': waterTankerIcon,
      'Rescue Car': rescueCarIcon,
    };
    _initUnitPositionsAndStartTimer();
  }

  void _initUnitPositionsAndStartTimer() {
    // Set initial positions for all units (spread around pos damkar)
    Map<String, LatLng> initialPositions = {};
    int unitIdx = 0;
    for (final damkar in damkarLocations) {
      final center = LatLng(damkar['lat'], damkar['lng']);
      final units = damkar['units'] as List;
      for (int i = 0; i < units.length; i++) {
        final unit = units[i];
        for (int j = 0; j < (unit['jumlah'] ?? 1); j++) {
          // Set initial angle for each unit
          double angle = (unitIdx * 2 * pi) / 12;
          double lat = center.latitude + _radius * cos(angle);
          double lng = center.longitude + _radius * sin(angle);
          initialPositions['${damkar['name']}_${unit['name']}_$j'] = LatLng(lat, lng);
          unitIdx++;
        }
      }
    }
    setState(() {
      unitPositions = initialPositions;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 500), _moveUnits);
  }

  void _moveUnits(Timer timer) {
    // Move each unit in a small circle around its pos damkar
    Map<String, LatLng> newPositions = {};
    int unitIdx = 0;
    for (final damkar in damkarLocations) {
      final center = LatLng(damkar['lat'], damkar['lng']);
      final units = damkar['units'] as List;
      for (int i = 0; i < units.length; i++) {
        final unit = units[i];
        for (int j = 0; j < (unit['jumlah'] ?? 1); j++) {
          double angle = (_angle + (unitIdx * 2 * pi) / 12) % (2 * pi);
          double lat = center.latitude + _radius * cos(angle);
          double lng = center.longitude + _radius * sin(angle);
          newPositions['${damkar['name']}_${unit['name']}_$j'] = LatLng(lat, lng);
          unitIdx++;
        }
      }
    }
    setState(() {
      unitPositions = newPositions;
      _angle += 0.1;
    });
  }

  Map<String, dynamic> _findNearestDamkar(double lat, double lng) {
    double minDist = double.infinity;
    Map<String, dynamic>? nearest;
    for (final damkar in damkarLocations) {
      final dLat = damkar['lat'] as double;
      final dLng = damkar['lng'] as double;
      final dist = ((lat - dLat) * (lat - dLat)) + ((lng - dLng) * (lng - dLng));
      if (dist < minDist) {
        minDist = dist;
        nearest = damkar;
      }
    }
    return nearest!;
  }

  @override
  Widget build(BuildContext context) {
    final LatLng? userLoc = currentLocation != null
        ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
        : null;
    final LatLng? damkarLoc = nearestDamkar != null
        ? LatLng(nearestDamkar!['lat'], nearestDamkar!['lng'])
        : null;
    final List units = nearestDamkar?['units'] ?? [];

    // Build all unit markers
    Set<Marker> unitMarkers = {};
    unitPositions.forEach((unitId, pos) {
      // Extract unit type from unitId
      String type = unitId.contains('Fire Truck')
          ? 'Fire Truck'
          : unitId.contains('Water Tanker')
              ? 'Water Tanker'
              : 'Rescue Car';
      unitMarkers.add(
        Marker(
          markerId: MarkerId(unitId),
          position: pos,
          icon: unitIcons[type] ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: unitId.split('_')[1]),
        ),
      );
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Armada tersedia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: damkarLoc == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onMapCreated: (controller) => mapController = controller,
                      initialCameraPosition: CameraPosition(
                        target: damkarLoc,
                        zoom: 13,
                      ),
                      markers: {
                        // Marker pos damkar terdekat
                        Marker(
                          markerId: const MarkerId('damkar_terdekat'),
                          position: damkarLoc,
                          infoWindow: InfoWindow(
                            title: nearestDamkar!['name'],
                            snippet: nearestDamkar!['address'],
                          ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                        ),
                        // Marker user
                        if (userLoc != null)
                          Marker(
                            markerId: const MarkerId('user'),
                            position: userLoc,
                            infoWindow: const InfoWindow(title: 'Lokasi Anda'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                          ),
                        // Semua marker unit
                        ...unitMarkers,
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                    ),
            ),
            const SizedBox(height: 16),
            const Text('Informasi armada terdekat', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (nearestDamkar != null)
              Card(
                color: Colors.red[100],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.local_fire_department, color: Colors.red),
                  title: Text(nearestDamkar!['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Nomor HP: ${nearestDamkar!['phone']}'),
                ),
              ),
            const SizedBox(height: 16),
            const Text('Unit tersedia', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...units.map((unit) => Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Image.asset(unit['image'], width: 56, height: 56, fit: BoxFit.contain),
                    title: Text(unit['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Status: ${unit['status']}\nJumlah: ${unit['jumlah']}'),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
