// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'google_map_page.dart';
// import 'package:geolocator/geolocator.dart';

// class UserLocation {
//   getLocation() async {
//     Position position = await Geolocator()
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);
//     setState(() {
//       _markers.clear();
//       final marker = Marker(
//           markerId: MarkerId("curr_loc"),
//           position: LatLng(currentLocation.latitude, currentLocation.longitude),
//           infoWindow: InfoWindow(title: 'Your Location'),
//       );
//       _markers["Current Location"] = marker;
//   }
// }