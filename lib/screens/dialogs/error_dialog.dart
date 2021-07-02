import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorDialog{
  static void showErrorDialog(BuildContext context, String title,String msg){
    showDialog(context: context, builder: (context)=>new AlertDialog(
      title: Text(title,style: GoogleFonts.play(
        fontWeight: FontWeight.bold
      ),),
      content: Text(msg),
      actions: [
        FlatButton(onPressed: (){
          Navigator.of(context).pop(context);
        }, child: Text('OK'))
      ],
    ));
  }
}