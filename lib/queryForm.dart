import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createAlertDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Title Text"),
        content: CupertinoTextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {},
            child: Text("Submit"),
          )
        ],
      );
    },
  );
}
