import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapsScreen extends ConsumerStatefulWidget {
  const MapsScreen({super.key});

  @override
  ConsumerState<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends ConsumerState<MapsScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _isLoading = true;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  // Default location (Manila, Philippines)
  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(14.5995, 120.9842),
    zoom: 15.0,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      // Add current location marker
      _addCurrentLocationMarker();

      // Animate to current location
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15.0,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addCurrentLocationMarker() {
    if (_currentPosition != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            infoWindow: const InfoWindow(
              title: 'Your Location',
              snippet: 'You are here',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });
    }
  }

  void _addSampleMarkers() {
    // Add some sample pickup/dropoff locations
    final sampleLocations = [
      {
        'id': 'pickup_1',
        'position': const LatLng(14.5995, 120.9842),
        'title': 'Pickup Location 1',
        'snippet': 'Customer waiting here',
        'color': BitmapDescriptor.hueGreen,
      },
      {
        'id': 'dropoff_1',
        'position': const LatLng(14.6100, 120.9900),
        'title': 'Dropoff Location 1',
        'snippet': 'Destination reached',
        'color': BitmapDescriptor.hueRed,
      },
      {
        'id': 'pickup_2',
        'position': const LatLng(14.5900, 120.9800),
        'title': 'Pickup Location 2',
        'snippet': 'Customer waiting here',
        'color': BitmapDescriptor.hueGreen,
      },
    ];

    for (final location in sampleLocations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location['id'] as String),
          position: location['position'] as LatLng,
          infoWindow: InfoWindow(
            title: location['title'] as String,
            snippet: location['snippet'] as String,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(location['color'] as double),
        ),
      );
    }
  }

  void _addSampleRoute() {
    // Add a sample route polyline
    final List<LatLng> routePoints = [
      const LatLng(14.5995, 120.9842), // Start
      const LatLng(14.6050, 120.9870), // Waypoint 1
      const LatLng(14.6100, 120.9900), // End
    ];

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route_1'),
          points: routePoints,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: FlexibleAppBar(
        title: 'Live Map',
        style: AppBarStyle.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _goToCurrentLocation,
          ),
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: _toggleMapType,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _addSampleMarkers();
                    _addSampleRoute();
                  },
                  initialCameraPosition: _currentPosition != null
                      ? CameraPosition(
                          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                          zoom: 15.0,
                        )
                      : _defaultLocation,
                  markers: _markers,
                  polylines: _polylines,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: true,
                  onTap: _onMapTapped,
                ),
                // Bottom action buttons
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      // Status card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Online - Ready for rides',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Tap to go offline',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings),
                              onPressed: () {
                                // Handle settings
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle accept ride
                              },
                              icon: const Icon(Icons.check_circle),
                              label: const Text('Accept Ride'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Handle decline ride
                              },
                              icon: const Icon(Icons.cancel),
                              label: const Text('Decline'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15.0,
          ),
        ),
      );
    }
  }

  void _toggleMapType() {
    // This would toggle between different map types
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Map type toggle - Coming soon!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onMapTapped(LatLng position) {
    // Handle map tap - could add new markers, show info, etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped at: ${position.latitude}, ${position.longitude}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
} 