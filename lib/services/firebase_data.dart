import 'package:firebase_database/firebase_database.dart';

class FireDatabase {
  DatabaseReference _database = FirebaseDatabase.instance.reference();

  void onCreateUser(String userId, String name, String phone,
      Function onSuccess, Function(String) onError) {
    var user = {'name': name, 'phone': phone};
    _database
        .child('user')
        .child(userId)
        .set(user)
        .then((user) => onSuccess())
        .catchError((error) {
      onError('Create user fail');
    });
  }


}
