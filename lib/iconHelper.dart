import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconHelper {
  var iconList;
  String userIconString = "assets/userIcon.png";
  String pizzaIconString = "assets/pizzaIcon.png";
  String foodIconString = "assets/foodIcon.png";
  String swagIconString = "assets/swagIcon.png";
  String etcIconString = "assets/etcIcon.png";
  void loadIcons()//0-pizza, 1-food, 2-swag, 3-etc.
  {
    iconList.append(BitmapDescriptor.fromAsset("assets/pizzaIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/foodIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/swagIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/etcIcon.png"));
    return iconList;
  }
}