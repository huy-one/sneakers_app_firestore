
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneakers_app_firestore/blocs/login_bloc.dart';
import 'package:sneakers_app_firestore/screens/register_page.dart';

import 'components/change_log_reg.dart';
import 'components/custom_LRbutton.dart';
import 'components/custom_LRtextfield.dart';
import 'components/footer.dart';
import 'components/text_formplay.dart';
import 'dialogs/error_dialog.dart';
import 'dialogs/loading_dialog.dart';
import 'home_page.dart';



class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  LoginBloc _loginBloc =LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/4.png')),
            TextFormPlay('Welcome Back! \n LOG IN'),
            CustomLRTextField(controller: _emailController, label: 'Email', iconData: Icons.email_outlined, stream: _loginBloc.emailStream,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _passController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: 'Password',
                  labelStyle: GoogleFonts.play(
                      fontSize: 20
                  ),
                  hintText: 'please input here',
                ),
              ),
            ),
            SizedBox(height: 40,),
            CustomLRbutton(title: 'Log In', press: (){
              onSignInClick();
            }, color: Colors.blueAccent.withOpacity(0.3)),
            SizedBox(height: 40,),
            ChangeLogReg(press: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterPage()));
            }, title: 'New to Onehe? Registration'),
            FooterPage(),
          ],
        ),
      ),
    );
  }

  void onSignInClick(){
    var email=_emailController.text;
    var password =_passController.text;
    LoadingDialog.showLoadingDialog(context);
    _loginBloc.SignIn(email, password, (){
     setState(() {
       LoadingDialog.hideLoadingDialog(context);
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
     });
    }, (msg){
     LoadingDialog.hideLoadingDialog(context);
      ErrorDialog.showErrorDialog(context, 'Error: ', msg);
    });
  }
}
