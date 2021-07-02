import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomLRTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData iconData;
  final Stream stream;
  const CustomLRTextField({Key? key, required this.controller, required this.label, required this.iconData, required this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            return TextField(
               controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(iconData),
                labelText: label,
                labelStyle: GoogleFonts.play(
                    fontSize: 20
                ),
                hintText: 'please input here',
                errorText: snapshot.hasError? snapshot.error.toString():null,
              ),

            );
          }
      ),
    );
  }
}
