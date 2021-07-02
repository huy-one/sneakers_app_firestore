import 'package:flutter/material.dart';
import 'package:sneakers_app_firestore/screens/components/custom_snackbar.dart';
import 'package:sneakers_app_firestore/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required FireStore fireStore,
    required this.data, required this.press,
  }) : _fireStore = fireStore, super(key: key);
  final VoidCallback press;
  final FireStore _fireStore;
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _fireStore.productRef
            .doc(data['productId'])
            .snapshots(),
        builder: (context, product){
          if(product.connectionState==ConnectionState.active){
            Map<String, dynamic> dataProduct =
            product.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(30, 0),
                              blurRadius: 4,
                              color: Colors.orangeAccent
                                  .withOpacity(0.5))
                        ]),
                        child: Image(
                          image: NetworkImage(
                              '${dataProduct['image'][0]}'),
                          fit: BoxFit.fitWidth,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${dataProduct['name']}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Size: ${data['size']}',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Price: \$ ${dataProduct['price']}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: press,

                        icon: Icon(Icons.cancel_outlined))
                  ],
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}