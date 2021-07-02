import 'package:flutter/material.dart';
import 'package:sneakers_app_firestore/screens/register_page.dart';
import 'package:sneakers_app_firestore/screens/signin_page.dart';
import 'components/custom_LRbutton.dart';
import 'components/footer.dart';
import 'components/text_formplay.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image(image: AssetImage('assets/images/1.png'),),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlueAccent,
                    offset: Offset(10, 120),
                    blurRadius: 60,
                  )
                ]
            ),
          ),
          TextFormPlay('ONE HE'),
          SizedBox(height: 40,),
          CustomLRbutton(color: Colors.blueAccent.withOpacity(0.4),
            title: 'Sign In',
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },),
          CustomLRbutton(color: Colors.pinkAccent.withOpacity(0.4),
            title: 'Sign Up',
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },),
          SizedBox(height: 40,),
          FooterPage()
        ],
      ),
    );
  }}