import 'package:flutter/material.dart';
//import 'package:freebeezswamphacks/filterForm.dart';
import 'package:freebeezswamphacks/postForm.dart';
//import 'package:freebeezswamphacks/filter.dart';

dialogBox(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add a new FreeBeeez'),
        content: SingleChildScrollView(child: PostPage()),
        actions: <Widget>[
          FlatButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// filterBox(BuildContext context, Filter filter) async {
//   final result = await Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => FilterPage(filter)),
//   );
//   return result;
// }
