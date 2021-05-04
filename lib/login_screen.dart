import 'package:coconeobank/HomeScreen.dart';
import 'package:coconeobank/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'configuration.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'CocoNeoBank',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () async{
        FirebaseAuth _auth=FirebaseAuth.instance;
        await _auth.currentUser().then((user) => user != null ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()))
            : Fluttertoast.showToast(msg: 'User Not registered Before'));
      },
      onRecoverPassword: _recoveryPassword,

    );
  }

  Future<String> _loginUser(LoginData loginData) {
    _handleSignIn(loginData.name.trim(),loginData.password)
      .then((user)=>Fluttertoast.showToast(
        msg: 'Welcome ${user.email}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.amber,
      fontSize: 16
    ))
      .catchError((e)=> Fluttertoast.showToast(
        msg: '${e}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16
    ));

  }

  Future<FirebaseUser> _handleSignIn(String email, String password) async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser _user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    return _user;
  }

  Future<String> _signUpUser(LoginData loginData) {
    _handleSignUp(loginData.name.trim(),loginData.password)
        .then((user)=>Fluttertoast.showToast(
        msg: 'Welcome ${user.email}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.amber,
        fontSize: 16
    ))
        .catchError((e)=> Fluttertoast.showToast(
        msg: '${e}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16
    ));
  }

  Future<FirebaseUser> _handleSignUp(String email, String password) async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser _user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return _user;
  }

  Future<String> _recoveryPassword(String email) async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email)
    .catchError((e)=> Fluttertoast.showToast(
        msg: '${e}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 16
    ));
  }
}



