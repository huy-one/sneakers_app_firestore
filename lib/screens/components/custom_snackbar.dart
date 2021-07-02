import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showCSnackBar (BuildContext context,String title){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
