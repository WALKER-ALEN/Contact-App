import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/url_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  final Function(double, double) onLocationPicked;

  const MapScreen({required this.onLocationPicked});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final isGranted = await requestLocationPermission();
    if (!isGranted){
       openAppSettings();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.4221, -122.0841), // Default to some location
          zoom: 15,
        ),
        onTap: (LatLng location) {
          setState(() {
            _pickedLocation = location;
          });
          widget.onLocationPicked(location.latitude, location.longitude);
        },
        markers: _pickedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('picked-location'),
                  position: _pickedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}
