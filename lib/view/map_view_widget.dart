import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatelessWidget {
  final LatLng ? contactLocation;
  const MapViewWidget({super.key, required this.contactLocation});

  @override
  Widget build(BuildContext context) {
    if(contactLocation== null){
      return Center(child: Text('not available'));
    }
    return GoogleMap(
      // onMapCreated: (controller) => _mapController = controller,
      initialCameraPosition: CameraPosition(
        target: contactLocation!, // Default to some location
        zoom: 15,
      ),
      markers: {
        Marker(markerId: MarkerId('contact-location'),
        position: contactLocation!)
      },
    );
    
  }
}
