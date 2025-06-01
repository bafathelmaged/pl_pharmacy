import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeiht;
  static double? defaultSize;
  static Orientation? orientation;
  final int mag = 2;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeiht = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeiht! * .024
        : screenWidth! * .024;
    print("this is defaulte size $defaultSize ");
  }
}
