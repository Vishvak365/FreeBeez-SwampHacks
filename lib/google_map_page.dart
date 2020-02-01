import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

final databaseReference = Firestore.instance;

class FreeMap extends StatefulWidget {
  @override
  _FreeMapState createState() => _FreeMapState();
}

class _FreeMapState extends State<FreeMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  static const LatLng _center = const LatLng(29.6479375, -82.3440625);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot != null) {
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
            markers: Set.from(allMarkers),
          );
        }
        return CircularProgressIndicator();
      },
      future: getData(),
    );
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

  //Functions

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  var data;

  //gets the postings from the database and puts them on the map
  Future<dynamic> getData() async {
    var val = Firestore.instance.collection('postings').getDocuments();
    val.then((val) {
      try {
        print(val.documents.length);
        for (int i = 0; i < val.documents.length; i++) {
          double lat = (val.documents[i].data["loc"].latitude);
          double lon = ((val.documents[i].data["loc"].longitude));
          //String title = (val.documents[i].data["title"]);
          //String description = (val.documents[i].data["description"]);
          allMarkers.add(
            Marker(
              markerId: MarkerId(i.toString()),
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
    return Firestore.instance.collection('postings').getDocuments();
  }

  //when the app boots up create the map and draw all the markers on the mapp
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

    Timer.periodic(Duration(seconds: 1), (Timer t) => getLocation());
  }
}
