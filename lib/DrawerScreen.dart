import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';
import 'login_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {

    FirebaseAuth _auth = FirebaseAuth.instance;

    return Container(
      color: primarycolor,

      child: Container(
        child: Column(

        children: <Widget>[

          GestureDetector(
            onTap:() {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            },

            child: Container(

              height: 100,
              width: 200,

              margin: EdgeInsets.symmetric(horizontal: 20),
              child:Row(
                children: <Widget>[
                  Expanded(child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 40, bottom: 20),
                        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20),),
                        //margin: EdgeInsets.only(top: 40),
                      ),
                      Align(

                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Center(
                              
                              child: Text("Welcome\n User" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),

                            ),




                              IconButton(
                                icon: Icon(Icons.exit_to_app), onPressed: () =>
                              {

                                _auth.signOut().then((value) =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            LoginScreen()),
                                            (route) => false))
                              },)

                            
                          ],
                        ),
                        
                      )
                    ],
                  )),


                ],

              ),
            ),

          ),


        ],

        ),
      ),
    );
  }
}
