import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
class DataGetter{
  getLocation(){
    return Firestore.instance.collection('postings').getDocuments();
  }
}