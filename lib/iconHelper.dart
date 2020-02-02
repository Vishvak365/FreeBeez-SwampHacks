import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconHelper {
  var iconList;
  static String userIconString = "assets/userIcon.png";
  static String pizzaIconString = "assets/pizzaIcon.png";
  static String foodIconString = "assets/foodIcon.png";
  static String swagIconString = "assets/swagIcon.png";
  static String etcIconString = "assets/etcIcon.png";
  void loadIcons()//0-pizza, 1-food, 2-swag, 3-etc.
  {
    iconList.append(BitmapDescriptor.fromAsset("assets/pizzaIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/foodIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/swagIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/etcIcon.png"));
    iconList.append(BitmapDescriptor.fromAsset("assets/userIcon.png"));
    userIconString = "assets/userIcon.png";
    pizzaIconString = "assets/pizzaIcon.png";
    foodIconString = "assets/foodIcon.png";
    swagIconString = "assets/swagIcon.png";
    etcIconString = "assets/etcIcon.png";
    return iconList;
  }
  String getUserIconString()
  {
    return userIconString;
  }
}