import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'home_widget.dart';

void main() => runApp(MyApp());
//void main() => runApp(AddDataToFireStore());
final databaseReference = Firestore.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreeBeez',
      home: HomePage(),
    );
  }

  void createRecord() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);

    DocumentReference ref = await databaseReference
        .collection("postings")
        .add({'loc': coordinates});
    print(ref.documentID);
  }
}

class Home {}
