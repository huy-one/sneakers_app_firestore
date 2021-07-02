
import 'package:flutter/material.dart';
import 'package:sneakers_app_firestore/blocs/login_bloc.dart';
import 'components/change_log_reg.dart';
import 'components/custom_LRbutton.dart';
import 'components/custom_LRtextfield.dart';
import 'components/footer.dart';
import 'components/text_formplay.dart';
import 'dialogs/error_dialog.dart';
import 'dialogs/loading_dialog.dart';
import 'home_page.dart';
import 'signin_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  LoginBloc _loginBloc = LoginBloc();
  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/4.png')),
            TextFormPlay('REGISTER HERE'),
            CustomLRTextField(
              controller: _nameController,
              label: 'UserName',
              iconData: Icons.sentiment_satisfied_rounded,
              stream: _loginBloc.nameStream,
            ),
            CustomLRTextField(
              controller: _emailController,
              label: 'Email',
              iconData: Icons.email_outlined,
              stream: _loginBloc.emailStream,
            ),
            CustomLRTextField(
              controller: _phoneController,
              label: 'Phone',
              iconData: Icons.phone_android_outlined,
              stream: _loginBloc.phoneStream,
            ),
            CustomLRTextField(
              controller: _passController,
              label: 'Password',
              iconData: Icons.lock_outline,
              stream: _loginBloc.passStream,
            ),
            CustomLRbutton(
                title: 'REGISTER',
                press: () {
                  onRegisterClick();
                },
                color: Colors.pinkAccent.withOpacity(0.3)),
            ChangeLogReg(
              title: 'Do you already have an account? Log in',
              press: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignInPage()));
              },
            ),
            FooterPage(),
          ],
        ),
      ),
    );
  }

  void onRegisterClick() {
    var name = _nameController.text;
    var email = _emailController.text;
    var password = _passController.text;
    var phone = _phoneController.text;
    LoadingDialog.showLoadingDialog(context);
    if (_loginBloc.isValid(name, email, phone, password)) {
      _loginBloc.Register(name, email, phone, password, () {
        setState(() {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        });
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        ErrorDialog.showErrorDialog(context, 'Error', msg);
      });
    }
  }
}

