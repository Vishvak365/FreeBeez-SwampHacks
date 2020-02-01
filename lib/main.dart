import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'getData.dart';

void main() => runApp(MyApp());
//void main() => runApp(AddDataToFireStore());
final databaseReference = Firestore.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  static const LatLng _center = const LatLng(29.6479375, -82.3440625);

  void _onMapCreated(GoogleMapController controller) {
    sleep(const Duration(seconds: 10));
    _controller.complete(controller);
  }

  var data;
  getData() async {
    return Firestore.instance.collection('postings').getDocuments();
  }

  void initState() {
    super.initState();
    getData().then((val) {
      data = val.documents;
      try {
        for (int i = 0; i < data.documents.length; i++) {
          double lat = (data.documents[i].data["loc"].latitude);
          double lon = ((data.documents[i].data["loc"].longitude));
          String title = (data.documents[i].data["title"]);
          //String description = (val.documents[i].data["description"]);
          allMarkers.add(
            Marker(
              markerId: MarkerId(title),
              draggable: true,
              position: LatLng(lat, lon),
              //infoWindow: InfoWindow(title: title, snippet: description)),
            ),
          );
        }
      } catch (e) {
        print("Out of bounds");
      }
    });

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
