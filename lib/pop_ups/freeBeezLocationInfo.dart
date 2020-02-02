import 'package:flutter/material.dart';

locationInfoPopUp(
    BuildContext context, String title, String description, String image_url) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Container(
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Image.network(
                  image_url,
                  width: MediaQuery.of(context).size.width,
                ),
                Text(description),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
