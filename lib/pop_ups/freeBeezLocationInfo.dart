import 'package:flutter/material.dart';
import 'package:freebeezswamphacks/freebee.dart';

locationInfoPopUp(BuildContext context, Freebee item) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(item.title),
        content: SingleChildScrollView(
          child: Container(
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Text(item.desc),
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
