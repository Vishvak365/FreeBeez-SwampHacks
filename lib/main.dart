import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_map_page.dart';
import 'package:geolocator/geolocator.dart';
import 'queryForm.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(title: "RaisedButton", home: MyApp()));
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
              markerId: MarkerId(title),
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
  }

  @override
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot != null) {
            return Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(29.6479375, -82.3440625),
                  zoom: 18.0,
                ),
                markers: Set.from(allMarkers),
              ),
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
              icon: Icon(Icons.filter_list),
              onPressed: () {
                queryData();
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
    );
  }

  void queryData() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "FLAT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void createRecord() async {
    print("--------------------------------------------");
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);

    print(coordinates);
    DocumentReference ref = await databaseReference
        .collection("postings")
        .add({'loc': coordinates});
    print(ref.documentID);
  }
}
