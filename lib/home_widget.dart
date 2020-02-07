import 'package:flutter/material.dart';
import 'pop_ups/newListing.dart';
import 'filter.dart';
import 'filterForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'google_map_page.dart';

final databaseReference = Firestore.instance;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  Filter filter = new Filter();
  Widget build(BuildContext context) {
    return Scaffold(
      body: FreeMap(filter),
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset('assets/bee.png'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter),
              onPressed: () async {
                 // Open up filter dialog and wait for new filter
                await filterBox(context, filter);
                // Update MapState with new filter
                setState(() {
                });
              },
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogBox(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // FUNCTIONS

  // Creates filterform dialog and returns new filter on dialog exit
  filterBox(BuildContext context, Filter filter2) async {
  var result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FilterPage(filter2)),
  );
    this.filter = result;
    return result;
  }
}
