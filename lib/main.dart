import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

final databaseReference = Firestore.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  static const LatLng _center = const LatLng(29.6479375, -82.3440625);

  


  void createRecord() async {
  await databaseReference.collection("postings")
      .document("1")
      .setData({
        'title': 'Mastering Flutter',
        'description': 'Programming Guide for Dart'
      });

    DocumentReference ref = await databaseReference.collection("postings")
        .add({
          'title': 'Flutter in Action',
          'description': 'Complete Programming Guide to learn Flutter'
        });
    print(ref.documentID);
  }  


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    createRecord();
  }


  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: _center));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(29.6479375, -82.3440625),
            zoom: 18.0,
          ),
          markers: Set.from(allMarkers),
        ),
      ),
    );
  }
}
