import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneakers_app_firestore/screens/tabs/cart_tab.dart';
import 'package:sneakers_app_firestore/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

AppBar CustomAppBar(Stream bloc,Color color,IconData iconLeading) {
  FireStore _firestore =FireStore();
  return AppBar(
    backgroundColor: color,
    leading: IconButton(
      icon: Icon(iconLeading),
      onPressed: () {},
    ),
    title: StreamBuilder(
        stream: bloc,
        builder: (context, snapshot) {
          return Text(
            'Welcome ${snapshot.data}'.toUpperCase(),
            style: GoogleFonts.play(),
          );
        }),
    actions: [
      cartCustom(firestore: _firestore)
    ],
  );
}

class cartCustom extends StatelessWidget {
  const cartCustom({
    Key? key,
    required FireStore firestore,
  }) : _firestore = firestore, super(key: key);

  final FireStore _firestore;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartTab()));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,color: Colors.black,),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.userRef.doc(_firestore.getUserId()).collection('cart').snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                int _totalItem =0;
                if(snapshot.connectionState == ConnectionState.active) {
                  List _documents = snapshot.data!.docs;
                  _totalItem = _documents.length;
                }
                return Text(_totalItem.toString(),style: TextStyle(
                  color: Colors.black
                ),);
              }
            ),
          )
        ],
      ),
    );
  }
}