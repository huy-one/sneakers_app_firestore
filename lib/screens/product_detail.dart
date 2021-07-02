import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_app_firestore/screens/components/custom_appbar.dart';
import 'package:sneakers_app_firestore/screens/components/custom_snackbar.dart';
import 'package:sneakers_app_firestore/screens/components/image_swipe.dart';
import 'package:sneakers_app_firestore/screens/components/product_size.dart';
import 'package:sneakers_app_firestore/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  FireStore _fireStore = FireStore();
  String _selectedSize = '';
  int price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        actions: [cartCustom(firestore: _fireStore)],
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: _fireStore.productRef.doc(widget.productId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              price = data['price'];
              List imageList = data['image'];
              List productSize = data['size'];
              _selectedSize = productSize[0];
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageSwipe(itemList: imageList),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sneaker: ${data['name']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\$ ${data['price']}',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${data['desc']}'),
                    ),
                    ProductSize(
                      itemList: productSize,
                      onSelected: (size) {
                        _selectedSize = size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () async {
                                await _addToSaved();
                                CustomSnackBar.showCSnackBar(
                                    context, 'Product added to the fav');
                              },
                              child: Icon(
                                Icons.assistant_outlined,
                                size: 50,
                              ),
                            ),
                          ),
                          FlatButton(
                            minWidth: 300,
                            height: 50,
                            onPressed: () {
                              addToCart();
                              CustomSnackBar.showCSnackBar(
                                  context, 'Product added to the cart');
                            },
                            child: Text(
                              'Add To Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.black,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future _addToSaved() {
    return _fireStore.userRef
        .doc(_fireStore.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedSize});
  }

  Future<void> addToCart() async {
    return _fireStore.userRef
        .doc(_fireStore.getUserId())
        .collection('cart')
        .doc(_fireStore.getCartId())
        .set({
      'productId': widget.productId,
      'size': _selectedSize,
      'price': price
    });
  }
}
