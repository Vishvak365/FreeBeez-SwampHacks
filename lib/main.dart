import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_map_page.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  final databaseReference = Firestore.instance;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('FreeBeez'),
            backgroundColor: Colors.blue[700],
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.local_post_office),
                onPressed: () {
                  createRecord();
                },
              )
            ]),
        body: gmap(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.filter),
              title: new Text('Filter'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.local_post_office),
              title: new Text('Post'),
            )
          ],
        ),
      ),
    );
  }

  void createRecord() async {

    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);

    DocumentReference ref = await databaseReference
        .collection("postings")
        .add({'loc': coordinates});
    print(ref.documentID);
    
  }
}
