import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final db = Firestore.instance;

class PostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PostPageState();
  }
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _post = PostForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Post')), //creates the title
        body: Container(
            //describes the body of the post
            padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0), //sets a padded border around form
            child: Builder(
                builder: (context) => Form(
                      key: _formKey, //assigns the key to the generated key
                      child: Column(
                          //create a list-like form
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //create the fields of the form
                            TextFormField(
                                //defines a field
                                decoration: InputDecoration(labelText: 'Title'),
                                validator: (value) {
                                  //if the user doesn't input a title, they get an error msg
                                  if (value.isEmpty) {
                                    return 'Please enter a title';
                                  }
                                },
                                onSaved: (val) =>
                                    setState(() => _post.title = val)),
                            TextFormField(
                                //defines a field
                                decoration:
                                    InputDecoration(labelText: 'Description'),
                                validator: (value) {
                                  //if the user doesn't input a title, they get an error msg
                                  if (value.isEmpty) {
                                    return 'Please enter a description';
                                  }
                                },
                                onSaved: (val) =>
                                    setState(() => _post.desc = val)),

                            Text(
                                'Location: My Location'), //to-do: put in dynamic location selection for user (currentl defaults to their phone's GPS coords)
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child: RaisedButton(
                                    onPressed: () {
                                      final form = _formKey.currentState;
                                      if (form.validate()) {
                                        form.save();
                                        _post
                                            .getGPS()
                                            .then((position) =>
                                                _post.save(position))
                                            /*
                                            .then(_showDialog(context,
                                                "Submission Succeeded"))
                                            .catchError(_showDialog(
                                                context, "Submssion Failed"));
                                                */
                                      }
                                    },
                                    child: Text('Submit')))
                          ]),
                    ))));
  }

  _showDialog(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class PostForm {
  String title = '';
  String desc = '';

  Future<Position> getGPS() {
    return Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> save(Position position) {
    GeoPoint coordinates = new GeoPoint(position.latitude, position.longitude);
    return db
        .collection("postings")
        .add({'title': this.title, 'desc': this.desc, 'loc': coordinates});
  }
}

class Freebee {
  String title = '';
  String desc = '';
  GeoPoint coordinates;

  Freebee({this.title, this.desc, this.coordinates});

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'coordinates': coordinates,
      };
}
