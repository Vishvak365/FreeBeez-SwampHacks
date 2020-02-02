import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_widget.dart';

void main() => runApp(MyApp()
    // MaterialApp(
    //   title: "RaisedButton",
    //   home: MyApp(),
    //   debugShowCheckedModeBanner: false,
    //   darkTheme: ThemeData(
    //     brightness: Brightness.dark,
    //   ),
    // ),
    );
//void main() => runApp(AddDataToFireStore());
final databaseReference = Firestore.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FreeBeez',
      home: HomePage(),
    );
  }
}
