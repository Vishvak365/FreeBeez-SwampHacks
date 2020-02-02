import 'dart:io';
import 'package:image/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';


class ImagePick extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImagePickState();
  }
}

class _ImagePickState extends State<ImagePick> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });

    uploadPic(image);
  }

  Future uploadPic(image) async {
    //String fileName = basename(image.path);
    StorageReference fbsRef =
    FirebaseStorage.instance.ref().child(basename(image));
    StorageUploadTask uploadTask = fbsRef.putFile(image);
    StorageTaskSnapshot taskSnapshots = await uploadTask.onComplete;
    setState(() {
      print("Freebee Picture uploaded");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
