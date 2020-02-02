import 'package:flutter/material.dart';

locationInfoPopUp(BuildContext context,String title, String description) {
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
                Text(description),
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
