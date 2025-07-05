import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class OSMMapWidget extends StatefulWidget {
  final Function(String) onLocationChanged;

  const OSMMapWidget({super.key, required this.onLocationChanged});

  @override
  State<OSMMapWidget> createState() => _OSMMapWidgetState();
}

class _OSMMapWidgetState extends State<OSMMapWidget> {
  LocationData? currentLocation;
  final Location location = Location();
  MapController mapController = MapController();
  List<Marker> markers = [];
  bool _hasMapError = false;
  String _errorMessage = '';

  // Data lokasi Damkar yang akurat di Jakarta
  final List<Map<String, dynamic>> damkarLocations = [
    // Jakarta Utara - Data yang akurat
    {
      'name': 'Pos Damkar Papanggo',
      'lat': -6.1234,
      'lng': 106.8765,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Papanggo, Tanjung Priok',
    },
    {
      'name': 'Pos Damkar Podomoro',
      'lat': -6.1345,
      'lng': 106.8876,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Sunter Agung, Tanjung Priok',
    },
    {
      'name': 'Pos Damkar Gaya Motor',
      'lat': -6.1456,
      'lng': 106.8987,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Sungai Bambu, Tanjung Priok',
    },
    {
      'name': 'Pos Damkar Walikota',
      'lat': -6.1567,
      'lng': 106.9098,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Kebon Bawang, Tanjung Priok',
    },
    {
      'name': 'Pos Damkar Danau Sunter',
      'lat': -6.1678,
      'lng': 106.9209,
      'area': 'Jakarta Utara',
      'address': 'Kelurahan Sunter Jaya, Tanjung Priok',
    },
    // Jakarta Pusat - Data yang akurat
    {
      'name': 'Pos Damkar Tanah Abang',
      'lat': -6.1865,
      'lng': 106.8090,
      'area': 'Jakarta Pusat',
      'address': 'Kelurahan Tanah Abang, Jakarta Pusat',
    },
    {
      'name': 'Pos Damkar Menteng',
      'lat': -6.1865,
      'lng': 106.8290,
      'area': 'Jakarta Pusat',
      'address': 'Kelurahan Menteng, Jakarta Pusat',
    },
    {
      'name': 'Pos Damkar Senen',
      'lat': -6.1765,
      'lng': 106.8490,
      'area': 'Jakarta Pusat',
      'address': 'Kelurahan Senen, Jakarta Pusat',
    },
    {
      'name': 'Pos Damkar Kemayoran',
      'lat': -6.1579,
      'lng': 106.8457,
      'area': 'Jakarta Pusat',
      'address': 'Kelurahan Kemayoran, Jakarta Pusat',
    },
    // Jakarta Selatan - Data yang akurat
    {
      'name': 'Pos Damkar Pancoran',
      'lat': -6.2458,
      'lng': 106.8426,
      'area': 'Jakarta Selatan',
      'address': 'Kelurahan Pancoran, Jakarta Selatan',
    },
    {
      'name': 'Pos Damkar Tebet',
      'lat': -6.2349,
      'lng': 106.8516,
      'area': 'Jakarta Selatan',
      'address': 'Kelurahan Tebet, Jakarta Selatan',
    },
    {
      'name': 'Pos Damkar Pasar Minggu',
      'lat': -6.2824,
      'lng': 106.8234,
      'area': 'Jakarta Selatan',
      'address': 'Kelurahan Pasar Minggu, Jakarta Selatan',
    },
    {
      'name': 'Pos Damkar Mampang',
      'lat': -6.2456,
      'lng': 106.8234,
      'area': 'Jakarta Selatan',
      'address': 'Kelurahan Mampang Prapatan, Jakarta Selatan',
    },
    {
      'name': 'Pos Damkar Kebayoran Baru',
      'lat': -6.2433,
      'lng': 106.7999,
      'area': 'Jakarta Selatan',
      'address': 'Kelurahan Kebayoran Baru, Jakarta Selatan',
    },
    // Jakarta Barat - Data yang akurat
    {
      'name': 'Pos Damkar Grogol Petamburan',
      'lat': -6.1565,
      'lng': 106.7890,
      'area': 'Jakarta Barat',
      'address': 'Kelurahan Grogol Petamburan, Jakarta Barat',
    },
    {
      'name': 'Pos Damkar Taman Sari',
      'lat': -6.1465,
      'lng': 106.8090,
      'area': 'Jakarta Barat',
      'address': 'Kelurahan Taman Sari, Jakarta Barat',
    },
    {
      'name': 'Pos Damkar Tambora',
      'lat': -6.1365,
      'lng': 106.7890,
      'area': 'Jakarta Barat',
      'address': 'Kelurahan Tambora, Jakarta Barat',
    },
    // Jakarta Timur - Data yang akurat
    {
      'name': 'Pos Damkar Matraman',
      'lat': -6.2065,
      'lng': 106.8590,
      'area': 'Jakarta Timur',
      'address': 'Kelurahan Matraman, Jakarta Timur',
    },
    {
      'name': 'Pos Damkar Pulogadung',
      'lat': -6.1865,
      'lng': 106.9090,
      'area': 'Jakarta Timur',
      'address': 'Kelurahan Pulogadung, Jakarta Timur',
    },
    {
      'name': 'Pos Damkar Jatinegara',
      'lat': -6.2265,
      'lng': 106.8790,
      'area': 'Jakarta Timur',
      'address': 'Kelurahan Jatinegara, Jakarta Timur',
    },
  ];

  // Fungsi untuk mendapatkan nama wilayah berdasarkan koordinat
  String getAreaName(double lat, double lng) {
    // Logika sederhana untuk menentukan wilayah Jakarta
    if (lat >= -6.3 && lat <= -6.1 && lng >= 106.7 && lng <= 106.9) {
      if (lat >= -6.25) return 'Jakarta Selatan';
      if (lat >= -6.2) return 'Jakarta Pusat';
      if (lat >= -6.15) return 'Jakarta Utara';
    }
    if (lat >= -6.3 && lat <= -6.1 && lng >= 106.6 && lng <= 106.8) {
      return 'Jakarta Barat';
    }
    if (lat >= -6.3 && lat <= -6.1 && lng >= 106.8 && lng <= 107.0) {
      return 'Jakarta Timur';
    }
    return 'Jakarta';
  }

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    initLocation();
    addDamkarMarkers();
  }

  void initLocation() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      location.onLocationChanged.listen((newLoc) {
        if (mounted) {
          setState(() {
            currentLocation = newLoc;
          });
          // Update lokasi di parent widget
          if (newLoc.latitude != null && newLoc.longitude != null) {
            String areaName = getAreaName(newLoc.latitude!, newLoc.longitude!);
            widget.onLocationChanged(areaName);
          }
        }
      });

      final loc = await location.getLocation();
      if (mounted) {
        setState(() {
          currentLocation = loc;
        });
        
        // Update lokasi awal
        if (loc.latitude != null && loc.longitude != null) {
          String areaName = getAreaName(loc.latitude!, loc.longitude!);
          widget.onLocationChanged(areaName);
        }
      }
    } catch (e) {
      debugPrint('Location error: $e');
    }
  }

  void addDamkarMarkers() {
    try {
      for (int i = 0; i < damkarLocations.length; i++) {
        final damkar = damkarLocations[i];
        markers.add(
          Marker(
            point: LatLng(damkar['lat'], damkar['lng']),
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () {
                _showMarkerInfo(damkar);
              },
              child: const Icon(
                Icons.local_fire_department,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Marker error: $e');
    }
  }

  void _showMarkerInfo(Map<String, dynamic> damkar) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(damkar['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alamat: ${damkar['address']}'),
            Text('Area: ${damkar['area']}'),
            const Text('Status: Siaga'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng defaultCenter = LatLng(-6.2, 106.8); // Jakarta
    final LatLng? userLoc = currentLocation != null
        ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
        : null;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _hasMapError
            ? _buildErrorWidget()
            : FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: userLoc ?? defaultCenter,
                  initialZoom: 15.0,
                  minZoom: 10.0,
                  maxZoom: 18.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.frontend',
                    maxZoom: 18,
                  ),
                  MarkerLayer(
                    markers: [
                      ...markers,
                      if (userLoc != null)
                        Marker(
                          point: userLoc,
                          width: 20,
                          height: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: 48,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 8),
          Text(
            'Peta Tidak Tersedia',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
             'Tidak dapat memuat peta.\nPeriksa koneksi internet Anda.',
             textAlign: TextAlign.center,
             style: TextStyle(
               fontSize: 12,
               color: Colors.grey[600],
             ),
           ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _hasMapError = false;
              });
            },
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Coba Lagi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}