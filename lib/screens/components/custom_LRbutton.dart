import 'package:flutter/material.dart';
class CustomLRbutton extends StatelessWidget {
  final String title;
  final VoidCallback press;
  final Color color;

  const CustomLRbutton({Key? key, required this.title, required this.press, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 300,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: FlatButton(
          onPressed: press,
          child: Text(title),
        ),
      ),
    );
  }
}