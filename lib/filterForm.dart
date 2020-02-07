import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'filter.dart';

final db = Firestore.instance;

class FilterPage extends StatefulWidget {
  final Filter filter;
  FilterPage(this.filter);
  State<StatefulWidget> createState() {
    return _FilterPageState();
  }
}

class _FilterPageState extends State<FilterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      //describes the body of the Filter
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0), //sets a padded border around form
      child: Builder(
        builder: (context) => Form(
          key: _formKey, //assigns the key to the generated key
          child: Column(
            //create a list-like form
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: RaisedButton(
                  child: new Text('Pizza'), color: widget.filter.allowedItems[0] ? Colors.blue : Colors.grey, onPressed: ()
                  {
                    setState(() {
                      widget.filter.allowedItems[0] = !widget.filter.allowedItems[0];
                    });
                  }
                  
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: RaisedButton(
                  onPressed: () {
                    // Update FilterPageState filter to match button information
                      setState(() {
                      widget.filter.allowedItems[1] = !widget.filter.allowedItems[1];
                    });
                  },
                  child: Text('Food'), color: widget.filter.allowedItems[1] ? Colors.blue : Colors.grey
                ),
              ),
                Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: RaisedButton(
                  onPressed: () {
                      setState(() {
                      widget.filter.allowedItems[2] = !widget.filter.allowedItems[2];
                    });
                  },
                  child: Text('Swag'), color: widget.filter.allowedItems[2] ? Colors.blue : Colors.grey
                ),
              ),
                Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: RaisedButton(
                  onPressed: () {
                      setState(() {
                      widget.filter.allowedItems[3] = !widget.filter.allowedItems[3];
                    });
                  },
                  child: Text('Etc.'), color: widget.filter.allowedItems[3] ? Colors.blue : Colors.grey
                ),
              ),
                Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: RaisedButton(
                  onPressed: () {
                      Navigator.pop(context, widget.filter);
                    },
                    child: Text('Exit'))
                ),]
              ),
          ),
        ),
      );
  }
}
