import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freebeezswamphacks/globals.dart' as globalVar;


class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => _ImagePickState();
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
    String path = basename(image.path);


    StorageReference fbsRef =
        FirebaseStorage.instance.ref().child('images/' + path);
    StorageUploadTask uploadTask = fbsRef.putFile(image);
    StorageTaskSnapshot taskSnapshots = await uploadTask.onComplete;
    //String downloadUrl = await taskSnapshots.ref.getDownloadURL();

    setState(() {
      print(path);
      globalVar.imagePath = path;
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
      )
    );
  }
}