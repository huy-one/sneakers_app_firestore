import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget TextFormPlay(String title) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(title,
        style: GoogleFonts.play(
            fontSize: 30,
            fontWeight: FontWeight.bold
        ),),
    ),
  );
}