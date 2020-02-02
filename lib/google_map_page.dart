import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:freebeezswamphacks/pop_ups/freeBeezLocationInfo.dart';
import 'iconHelper.dart';
import 'freebee.dart';
import 'package:freebeezswamphacks/globals.dart' as globalVar;


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
          return Center(
              child: Card(
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              width: MediaQuery.of(context).size.width * .9,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 18.0,
                ),
                markers: Set.from(allMarkers),
              ),
            ),
          ));
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

  // int CountNearby(List<Marker> markers, Position pos){ //if we need to count how many markers are near the user.
  //   int count = 0;

  //   for(int i = 0; i < markers.length; i++){
  //     if(markers[i].position.latitude - pos.latitude < 0.0075 && markers[i].position.latitude - pos.latitude > -0.0075){ //check if latitudes are 0.0075degrees within each other
  //       if(markers[i].position.longitude - pos.longitude < 0.0075 && markers[i].position.longitude - pos.longitude > -0.0075){
  //         count++;
  //       }
  //     }
  //   }

  //   return count;
  // }

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
    userIcon = BitmapDescriptor.fromAsset("assets/userIcon.png");
    Timer.periodic(Duration(seconds: 1), (Timer t) => getLocation());
  }
}
