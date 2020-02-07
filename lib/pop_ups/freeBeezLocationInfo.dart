import 'package:flutter/material.dart';
import 'package:freebeezswamphacks/freebee.dart';
//import 'package:share/share.dart';

locationInfoPopUp(BuildContext context, Freebee item) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(item.title),
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Image.network(
                    item.imageURL,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Description: ${item.desc}"),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Meeting Required: ${item.meetingRequired.toString() == 'true' ? 'yes' : 'no'}"),
                )
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
