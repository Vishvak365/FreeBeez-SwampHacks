import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:freebeezswamphacks/pop_ups/freeBeezLocationInfo.dart';
import 'iconHelper.dart';
import 'freebee.dart';

final databaseReference = Firestore.instance;

class FreeMap extends StatefulWidget {
  @override
  _FreeMapState createState() => _FreeMapState();
}

class _FreeMapState extends State<FreeMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  static const LatLng _center = const LatLng(29.6479375, -82.3440625);
  BitmapDescriptor userIcon;
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
        icon: userIcon,
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


  //removes old posts from DB, returns true if the document is removed.
  bool RemoveIfOutdated(Freebee fb, String docID){
    DateTime today = new DateTime.now();

    DateTime fbTimeCheck = fb.postingTime.toDate().add(Duration(days: 1));

    if(fbTimeCheck.isBefore(today)){
      Firestore.instance.collection('postings')
        .document(docID).delete();

      return true;
    }
    else{
      return false;
    }

  }

  //gets the postings from the database and puts them on the map
  Future<dynamic> getData() async {
    var val = Firestore.instance.collection('postings').getDocuments();
    val.then((val) {
      try {
        //print(val.documents.length);
        for (int i = 0; i < val.documents.length; i++) {
          bool remove = false;
          Freebee freebee = Freebee();
          try {
            freebee.createFromDB(val.documents[i].data);
            remove = RemoveIfOutdated(freebee, val.documents[i].documentID);
          } catch (error) {
            print(error);
          }

          if(!remove){
            allMarkers.add(
              Marker(
                  markerId: MarkerId(i.toString()),
                  draggable: true,
                  position: LatLng(freebee.coordinates.latitude,
                      freebee.coordinates.longitude),
                  onTap: () {
                    locationInfoPopUp(context, freebee);
                  },
                  icon: BitmapDescriptor.fromAsset(
                      IconHelper().itemTypeToString(freebee.itemCode))
                  //infoWindow: InfoWindow(title: title, snippet: description)),
                  ),
            );
          }
        }
      } catch (e) {
        //print(e);
      }
    });
    return Firestore.instance.collection('postings').getDocuments();
  }

  BitmapDescriptor customIcon;
  //when the app boots up create the map and draw all the markers on the mapp
  void initState() {
    super.initState();
    getData();

    IconHelper iconHelper;
    //String userIconString = iconHelper.getUserIconString();
    userIcon = BitmapDescriptor.fromAsset("assets/userIcon.png");
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          //print('Marker Tapped');
        },
        position: _center));

    Timer.periodic(Duration(seconds: 1), (Timer t) => getLocation());
  }
}
