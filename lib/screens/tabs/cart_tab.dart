import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_app_firestore/screens/components/cart_item_card.dart';
import 'package:sneakers_app_firestore/screens/components/custom_snackbar.dart';
import 'package:sneakers_app_firestore/screens/components/footer.dart';
import 'package:sneakers_app_firestore/screens/product_detail.dart';
import 'package:sneakers_app_firestore/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  FireStore _fireStore = FireStore();
  int totalPrice =0,sum=0;
  @override
  void initState() {
    FirebaseFirestore.instance.collection('user/${_fireStore.getUserId()}/cart').get().then(
          (querySnapshot) {
        querySnapshot.docs.forEach((result) {
          sum = sum + int.parse(result.data()['price'].toString());
        });
        setState(() {
          totalPrice = sum;
        });
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: _fireStore.userRef
                      .doc(_fireStore.getUserId())
                      .collection('cart')
                      .snapshots(),
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
                        scrollDirection: Axis.vertical,
                        children: snapshot.data!.docs.map((document) {
                          Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                          return GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetail(productId: data['productId'])));
                              },
                              child: CartItemCard(fireStore: _fireStore, data: data, press: () {
                                setState(() {
                                  FirebaseFirestore.instance.collection('user/${_fireStore.getUserId()}/cart').doc(_fireStore.getCartId()).delete().then((value){
                                    print(_fireStore.getCartId());
                                    CustomSnackBar.showCSnackBar(context, 'Delete product for cart');
                                  }).catchError((error){
                                    CustomSnackBar.showCSnackBar(context, '${error.code}');
                                  });
                                });
                              },));
                        }).toList());
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration:BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Total',style: TextStyle(
                      fontSize: 30,
                      color: Colors.white
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text('$totalPrice \$',style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            FooterPage(),
          ],
        ),
    );
  }
}


