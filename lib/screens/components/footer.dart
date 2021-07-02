import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterPage extends StatelessWidget {
  const FooterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.stream),
          Text(' co.OneHe Technology!',style: GoogleFonts.play(
          ),),
        ],
      ),
    );
  }
}