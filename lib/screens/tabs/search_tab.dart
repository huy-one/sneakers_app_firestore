import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0,10),
                blurRadius: 30,
                color: Colors.blueAccent.withOpacity(0.3)
              )
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Enter name sneaker want find',
              border: OutlineInputBorder(),
            ),

          ),
        ),
      ),
    );
  }
}
