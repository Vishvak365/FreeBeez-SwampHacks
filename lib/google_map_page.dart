import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GoogleMap gmap() {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  const LatLng _center = const LatLng(29.6479375, -82.3440625);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: true,
      onTap: () {
        print('Marker Tapped in global_map_page');
      },
      position: _center));

  return GoogleMap(
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
      target: LatLng(29.6479375, -82.3440625),
      zoom: 18.0,
    ),
    markers: Set.from(allMarkers),
  );
}
