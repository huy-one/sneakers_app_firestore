import 'dart:async';

import '../services/login_auth_service.dart';


class LoginBloc{
  LRAuthService _authService =LRAuthService();

  StreamController _nameController =new StreamController();
  StreamController _emailController =new StreamController();
  StreamController _phoneController =new StreamController();
  StreamController _passwordController =new StreamController();

  Stream get nameStream =>_nameController.stream;
  Stream get emailStream =>_emailController.stream;
  Stream get phoneStream =>_phoneController.stream;
  Stream get passStream =>_passwordController.stream;

  bool isValid(String name,String email,String phone,String pass){
    if(name.isEmpty || name.length==0){
      _nameController.sink.addError('please try again');
      return false;
    }
    _nameController.sink.add('');
  if(email.isEmpty || email.length==0||!email.contains('@')){
      _emailController.sink.addError('please try again');
      return false;
    }
    _emailController.sink.add('');
  if(phone.isEmpty || phone.length==0){
      _phoneController.sink.addError('please try again');
      return false;
    }
    _phoneController.sink.add('');
  if(pass.isEmpty || pass.length==0){
      _passwordController.sink.addError('please try again');
      return false;
    }
    _passwordController.sink.add('');
  return true;
  }

  void Register(String name,String email,String phone,String password,Function onSuccess,Function(String) onError){
    _authService.RegisterWithEmailAndPassword(name, email, phone, password, onSuccess, onError);
  }

  void SignIn(String email,String password,Function onSuccess,Function(String) onError){
    _authService.SignInWithEmailAndPassword(email, password, onSuccess, onError);
  }

  void dispose(){
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passwordController.close();
  }

}