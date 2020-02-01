import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_map_page.dart';
import 'package:geolocator/geolocator.dart';

import 'icon_creator.dart';

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
    _controller.complete(controller);
  }

  getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    //GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);
    setState(() {
      //allMarkers.clear();
      
      final marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(270.00),
          markerId: MarkerId("curr_loc"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
      );
      allMarkers.removeWhere((item) => item.markerId.value == "curr_loc");
      allMarkers.add(marker);
    });
    //print("Updated location");
  }

  var data;
  Future<dynamic> getData() async {
    var val = Firestore.instance.collection('postings').getDocuments();
    val.then((val) {
      try {
        print(val.documents.length);
        for (int i = 0; i < val.documents.length; i++) {
          double lat = (val.documents[i].data["loc"].latitude);
          double lon = ((val.documents[i].data["loc"].longitude));
          String title = (val.documents[i].data["title"]);
          //String description = (val.documents[i].data["description"]);
          allMarkers.add(
            Marker(
              markerId: MarkerId("marker2"),
              draggable: true,
              position: LatLng(lat, lon),
              //infoWindow: InfoWindow(title: title, snippet: description)),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    });
    return Firestore.instance.collection('testPostings').getDocuments();
  }

  void initState() {
    super.initState();
    getData();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: _center));
    Timer timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getLocation());
  }

  @override
  final databaseReference = Firestore.instance;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot != null) {
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(29.6479375, -82.3440525),
                  zoom: 18.0,
                ),
                markers: Set.from(allMarkers),
              );
            }
            return CircularProgressIndicator();
          },
          future: getData(),
        ),
        appBar: AppBar(
            title: Text('FreeBeez'),
            backgroundColor: Colors.blue[700],
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(Icons.local_post_office),
                onPressed: () {
                  createRecord();
                  getLocation();
                },
              )
            ]),
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
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);

    DocumentReference ref = await databaseReference
        .collection("postings")
        .add({'loc': coordinates});
    print(ref.documentID);
  }
}
