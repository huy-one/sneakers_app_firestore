import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FireStore{
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> collectionStream =
  FirebaseFirestore.instance.collection('products').snapshots();


  final CollectionReference productRef = FirebaseFirestore.instance.collection('products');
  final CollectionReference userRef = FirebaseFirestore.instance.collection('user');
   String getUserId(){
    return  _auth.currentUser!.uid;
  }
  static String cartId='';
  String getCartId(){
  DocumentReference ref = userRef.doc(getUserId()).collection("cart").doc();
   cartId=ref.id;
   return cartId;
  }

 }