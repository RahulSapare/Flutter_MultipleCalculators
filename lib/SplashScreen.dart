import 'package:coconeobank/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkUserAlreadyLogin().then((isLogin) {
      if (isLogin == true) {
        print('Alrady Login');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeSceen()),
            (route) => false);
      } else {
        print('Not Login');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });

    return new Scaffold(
      body: Card(
        child: Center(
          child: Text(
            'Coco NeoBank',
            style: TextStyle(
                color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

checkUserAlreadyLogin() async{
  FirebaseAuth _auth = FirebaseAuth.instance;
  return _auth.currentUser().then((user) => user != null ? true : false).catchError((onError) => false);
}
