
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_data.dart';
class LRAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FireDatabase _database = FireDatabase();

  void RegisterWithEmailAndPassword(String name, String email, String phone,
      String password, Function onSuccess, Function(String) onError)  {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) => _database.onCreateUser(
            _auth.currentUser!.uid, name, phone, onSuccess, onError))
        .catchError((error) {
      onError('Error is: ' + error.code);
    });
  }

 void SignInWithEmailAndPassword(String email, String password,
      Function onSuccess, Function(String) onError)  => _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) => onSuccess())
        .catchError((error) {
      onError('Error is: ' + error.code);
    });

  void signOut(){
    _auth.signOut();
  }
}
