import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class PinInformation {
   String title;
   String desc;
   LatLng location;
   String locationName;
   String picturePath;
   PinInformation({
      this.title,
      this.desc,
      this.location,
      this.locationName,
      this.picturePath});
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  static const LatLng _center = const LatLng(29.6479375, -82.3440625);

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
    title: '',
    desc: '',
    location: LatLng(0,0),
    locationName: '',
    picturePath: ''
  );
  PinInformation sourcePinInfo;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    //setMapPins();
  }
    void _showcontent() {
    showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('You clicked on'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('This is a Dialog Box. Click OK to Close.'),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          _showcontent();
         setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
         });
      },
        position: _center));
    allMarkers.add(Marker(
        markerId: MarkerId('Turlington'),
        position: LatLng(29.648835, -82.343570),
        //infoWindow: InfoWindow(title: "Beach VolleyBall Club",snippet: "Come chat with us and get free pizza"),
        onTap: () {
          print("Casdfkljasdf");
          _showcontent();
          //return new AlertDialog(title: Text("yeet"),content: Container(color: Colors.blue));
        //  setState(() {Yeet"
        //     currentlySelectedPin = sourcePinInfo;
        //     pinPillPosition = 0;
        //  });
      }));
        
        
  }

  // void setMapPins() {
  //  // add the source marker to the list of markers
  //  allMarkers.add(Marker(
  //     marker.markerId: MarkerId(‘sourcePin’),
  //     position: SOURCE_LOCATION,
  //     onTap: () {
  //        setState(() {
  //           currentlySelectedPin = sourcePinInfo;
  //           pinPillPosition = 0;
  //        });
  //     },
  //    icon: sourceIcon
  //  ));
  //  // populate the sourcePinInfo object
  //  sourcePinInfo = PinInformation(
  //     locationName: “Start Location”,
  //     location: SOURCE_LOCATION,
  //     pinPath: “assets/driving_pin.png”,
  //     avatarPath: “assets/friend1.jpg”,
  //     labelColor: Colors.blueAccent
  //  );
  //  // add the destination marker to the list of markers
  //  _markers.add(Marker(
  //     marker.markerId: MarkerId(‘destPin’),
  //     position: DEST_LOCATION,
  //     onTap: () {
  //        setState(() {
  //           currentlySelectedPin = destinationPinInfo;
  //           pinPillPosition = 0;
  //        });
  //     },
  //     icon: destinationIcon
  //  ));
  //  destinationPinInfo = PinInformation(
  //     locationName: “End Location”,
  //     location: DEST_LOCATION,
  //     pinPath: “assets/destination_map_marker.png”,
  //     avatarPath: “assets/friend2.jpg”,
  //     labelColor: Colors.purple
  //  );
//}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(29.6479375, -82.3440625),
              zoom: 18.0,
            ),
            markers: Set.from(allMarkers),
        ),
        AnimatedPositioned(
          bottom: pinPillPosition, right: 0, left: 0,
          duration: Duration(milliseconds: 200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center)
          // wrap it inside an Alignment widget to force it to be
          // aligned at the bottom of the screen
        )
          ]
        )
      ),
    );
  }
}
