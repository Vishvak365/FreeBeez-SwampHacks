import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_map_page.dart';
import 'package:geolocator/geolocator.dart';

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
  _showDialog() {
    print("Entering show Dialog");
    showDialog(
      context: context, //never makes it past this line, something wrong with context
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        // return Dialog(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        //   elevation: 16,
        //   child: Container(
        //     height: 400.0,
        //     width: 360.0,
        //     child: ListView(
        //       children: <Widget>[
        //         SizedBox(height: 20),
        //         Center(
        //           child: Text(
        //             "Leaderboard",
        //             style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //         SizedBox(height: 20),
        //         // _buildName(imageAsset: 'assets/chocolate.jpg', name: "Name 1", score: 1000),
        //         // _buildName(imageAsset: 'assets/chocolate.jpg', name: "Name 2", score: 2000),
        //         // _buildName(imageAsset: 'assets/chocolate.jpg', name: "Name 3", score: 3000),
        //         // _buildName(imageAsset: 'assets/chocolate.jpg', name: "Name 4", score: 4000),
        //         // _buildName(imageAsset: 'assets/chocolate.jpg', name: "Name 5", score: 5000),
        //         // _buildName(imageAsset: 'assets/chocolate.jpg', name: "Name 6", score: 6000),
        //       ],
        //     ),
        //   ),
        // );
      }
    );
    print("finished show dialog");
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
          print("Before show dialog");
          _showDialog();
          print('Marker Tapped in main');
        },
        position: _center));
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
                  target: LatLng(29.6479375, -82.3440625),
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
                  _showDialog();
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
