import 'package:coconeobank/CurrencyConverterState.dart';
import 'package:coconeobank/RetirementCalculator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'configuration.dart';
import 'EmiCalculator.dart';


class HomeSceen extends StatefulWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _HomeSceenState createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {

  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;

  bool isdraweropen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(

      transform: Matrix4.translationValues(xoffset, yoffset, 0)..scale(scalefactor),


      duration: Duration(milliseconds: 250),
      color: Colors.white,
      child: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            SizedBox(height: 35,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  isdraweropen? IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: (){
                        setState(() {
                          xoffset = 0;
                          yoffset = 0;
                          scalefactor = 1;
                          isdraweropen = false;
                        });
                      }):

                  IconButton(icon: Icon(Icons.menu),onPressed: (){
                    setState(() {
                      xoffset= 250;
                      yoffset= 150;
                      scalefactor= 0.6;
                      isdraweropen= true;
                    });
                  },),

                  Column(
                    children: <Widget>[
                      Text("Coco NeoBank", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),

                    ],
                  ),

                ],
              ),
            ),

            ////////////////////////////////////////////////////////////////////////////////////

            GestureDetector(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EmiCalulator()));
              },

                child: Container(

                  height: 240,

                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child:Row(
                    children: <Widget>[
                      Expanded(child: Stack(
                        children: <Widget>[
                          Container(

                            decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(20), boxShadow: ListShadow),
                              margin: EdgeInsets.only(top: 40),
                          ),
                          Align(

                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(

                                child: Text("home loan calculator", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),

                                ),
                              ],
                            ),
                          )
                        ],
                      )),

                      Expanded(
                        child: Container(
                          height: 200,
                          margin: EdgeInsets.only(top: 60, bottom: 20),
                          decoration: BoxDecoration(color: Colors.white, boxShadow: ListShadow,borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20),)),

                          child:Center(

                          child:Text("home loan\n"
                              "calculator helps\n"
                              " you calculate the\n"
                              "equated monthly"
                            , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),),
                        ),
                        ),
                      ),
                    ],

                  ),
                ),

            ),

            /////////////////////////////////////////////////////////////////////////////////

            GestureDetector(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RetirementCalculator()));
              },

              child: Container(

                height: 240,

                margin: EdgeInsets.symmetric(horizontal: 20),
                child:Row(
                  children: <Widget>[
                    Expanded(child: Stack(
                      children: <Widget>[
                        Container(

                          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20), boxShadow: ListShadow),
                          margin: EdgeInsets.only(top: 40),
                        ),
                        Align(

                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(

                                child: Text("Retirement Calculator", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),

                              ),
                            ],
                          ),
                        )
                      ],
                    )),

                    Expanded(
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 60, bottom: 20),
                        decoration: BoxDecoration(color: Colors.white, boxShadow: ListShadow,borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20),)),

                        child:Center(

                        child:Text("Retirement calculator\n"
                            "is a tool that allows\n"
                            "you to figure out how\n"
                            "much money you will need\n"
                            "after you retire from paid,\n"
                            "active work"
                          , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),),
                        ),
                      ),
                    ),
                  ],

                ),
              ),

            ),

            ////////////////////////////////////////////////////////////////////////////////////////////////////

            GestureDetector(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CurrencyConverter()));
              },

              child: Container(

                height: 240,

                margin: EdgeInsets.symmetric(horizontal: 20),
                child:Row(
                  children: <Widget>[
                    Expanded(child: Stack(
                      children: <Widget>[
                        Container(

                          decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(20), boxShadow: ListShadow),
                          margin: EdgeInsets.only(top: 40),
                        ),
                        Align(

                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(

                                child: Text("Currency Converter", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),

                              ),
                            ],
                          ),
                        )
                      ],
                    )),

                    Expanded(
                      child: Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 60, bottom: 20),
                        decoration: BoxDecoration(color: Colors.white, boxShadow: ListShadow,borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20),)),

                        child:
                            
                          Center(
                            child: Text("Currency converter\n"
                             "is designed to convert\n"
                             " one currency to another\n"
                               "in order to check its\n"
                                     "corresponding value"
                               , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),),
                          ),
                      ),
                    ),
                  ],

                ),
              ),

            ),

    /////////////////////////////////////////////////////////////////////////////////////



          ],


        ),
      ),
    );
  }
}
