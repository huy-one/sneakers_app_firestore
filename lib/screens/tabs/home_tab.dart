import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneakers_app_firestore/screens/product_detail.dart';
import 'package:sneakers_app_firestore/services/firestore.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  FireStore _fireStore =FireStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collectionStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    children: snapshot.data!.docs.map((document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                            ProductDetail(productId: document.id),
                          ));
                          },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.3),
                            ],
                            begin: Alignment(0, 0),
                            end: Alignment(0, 1),
                          )),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                      width: 400,
                                      height: 300,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 12),
                                          blurRadius: 80,
                                        )
                                      ]),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(
                                          image: NetworkImage(data['image'][0]),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  Positioned(
                                    top: 30,
                                    right: 30,
                                    left: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data['name'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '\$ ${data['price']}',
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList());
              })
        ],
      ),
    );
  }
}
