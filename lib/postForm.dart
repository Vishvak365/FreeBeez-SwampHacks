import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'camera_widget.dart';
import 'freebee.dart';
import 'package:freebeezswamphacks/globals.dart' as globalVar;

final db = Firestore.instance;

class PostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PostPageState();
  }
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final freebee = Freebee();

  @override
  Widget build(BuildContext context) {
    return Container(
      //describes the body of the post
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0), //sets a padded border around form
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
                  onSaved: (val) => setState(() => freebee.title = val)),
              TextFormField(
                  //defines a field
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    //if the user doesn't input a title, they get an error msg
                    if (value.isEmpty) {
                      return 'Please enter a description';
                    }
                  },
                  onSaved: (val) => setState(() => freebee.desc = val)),
              SwitchListTile(
                  title: const Text('Do you have to go to a meeting?'),
                  value: freebee.meetingRequired,
                  onChanged: (bool val) =>
                      setState(() => freebee.meetingRequired = val)),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImagePick()),
                    );
                  },
                  child: Text('Upload a picture!'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: RaisedButton(
                  //the submit button
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      Navigator.of(context).pop();
                      freebee.imageURL = globalVar.imagePath;
                      freebee.updateGPS().then((val) => freebee.save());
                    }
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
