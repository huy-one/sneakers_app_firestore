import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeBloc{
  StreamController _nameController =new StreamController();
  Stream get nameStream =>_nameController.stream;

  FirebaseAuth _auth =FirebaseAuth.instance;
  DatabaseReference _database = FirebaseDatabase.instance.reference();

  void getName(){
    _database.child('user').child(_auth.currentUser!.uid).once().then((DataSnapshot dataSnapshot){
      _nameController.sink.add(dataSnapshot.value['name']);
    });
  }

  void dispose(){
    _nameController.close();
  }
}