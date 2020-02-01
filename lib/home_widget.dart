import 'package:flutter/material.dart';
import 'placeholder_widget.dart';
import 'postForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'google_map_page.dart';

final databaseReference = Firestore.instance;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int navIndex = 0; //used to access the array of the navigation bar
  final List<Widget> children = [
    FreeMap(),
    PostPage(),
    PlaceholderWidget(Colors.deepOrange),
  ]; //final is equivalent to const in other languages

  Widget build(BuildContext context) {
    return Scaffold(
      body: children[
          navIndex], //sets the body equal to the corresponding widget in the children list
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedIcon,
        currentIndex: navIndex,
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('Map'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.local_post_office),
            title: new Text('Post'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.filter),
            title: new Text('Filter'),
          ),
        ],
      ),
    );
  }

  

  void onTappedIcon(int index) {
    setState(() {
      navIndex = index;
    });
  }
}

void createRecord() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);

  DocumentReference ref =
      await databaseReference.collection("postings").add({'loc': coordinates});
  print(ref.documentID);
}

/*
Scaffold(
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
        
        
      ),
      */
