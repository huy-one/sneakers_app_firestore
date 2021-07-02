import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog{
  static void showLoadingDialog(BuildContext context){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context)=>new Dialog(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Image(image: AssetImage('assets/images/loading2.gif'),)),
    ));
  }
  static void hideLoadingDialog(BuildContext context){
    Navigator.of(context).pop( LoadingDialog());
  }
}