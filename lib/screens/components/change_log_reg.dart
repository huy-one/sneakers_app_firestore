import 'package:flutter/material.dart';
class ChangeLogReg extends StatelessWidget {
  final VoidCallback press;
  final String title;

  const ChangeLogReg({Key? key, required this.press, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: press,
        child: Text(title),
      ),
    );
  }
}