import 'dart:math';

import 'package:coconeobank/configuration.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class EmiCalulator extends StatefulWidget {


  @override
  _EmiCalulatorState createState() => _EmiCalulatorState();
}

class _EmiCalulatorState extends State<EmiCalulator> {

  final fb = FirebaseDatabase.instance;

  void initState() {
    super.initState();
  }

  List _tenureTypes = ['Month(s)','Year(s)'];
  String _tenureType = "Year(s)";
  String _loanResult = "";
  bool _switchValue = true;
  String princi="";


  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  @override



  Widget build(BuildContext context) {
    final ref = fb.reference().child("Home Loan Section");
    WidgetsFlutterBinding.ensureInitialized();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text("Home Loan Calculator", style: TextStyle(color: primarycolor, fontSize: 20),),
        elevation: 0.0,

      ),

      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[


              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _principalAmount,
                  decoration: InputDecoration(
                      labelText: "Enter Principal Amount"
                  ),
                  keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        princi = val;
                      });
                    }
                ),
              ),


              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _interestRate,
                  decoration: InputDecoration(
                      labelText: "Intrest Rate"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),


              Container(
                padding: EdgeInsets.all(20.0),
                child:
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: TextFormField(
                        controller: _tenure,
                        decoration: InputDecoration(
                            labelText: "Tenure"
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Flexible(

                      child: Column(
                        children: [
                          Text(_tenureType,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),

                          Switch(
                            value: _switchValue,
                            onChanged: (bool value){
                              print(value);
                              setState(() {

                                if(value){
                                  _tenureType = _tenureTypes[1];
                                }else{
                                  _tenureType = _tenureTypes[0];
                                }

                                _switchValue = value;
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),

              ),

              Flexible(
                fit: FlexFit.loose,
                child: FlatButton(

                  onPressed:(){

                    _handleCalculation();

                    ref.child("PrincipalAmount").set(princi);

                    },
                  child: Text("CALCULATE"),
                  color: Colors.amber,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0, right: 24.0),

                ),

              ),

              loanResultsWidget(_loanResult)

            ],
          ),
        ),
      ),



    );
  }

  void _handleCalculation(){

    // formulation
    ///// A = Payment amount per period
    ///// P = Loan Amount
    ///// r = interest rate
    ///// n = period

    double A = 0.0;
    int p = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)" ? int.parse(_tenure.text) * 12 : int.parse(_tenure.text);

    A = (p * r * pow((1+r), n) / (pow((1+r), n) -1));

    _loanResult = A.toStringAsFixed(2);

    setState(() {

    });
  }
  /*void _saveData() {
    print("came in SaveData");
    String principalAmount = _principalAmount.text;
    String IntrestRate = _interestRate.text;
    String Tenure = _tenure.text;
    String Result = _loanResult;

    Map <String, dynamic> homeLoan={
      'Principal Amount':principalAmount,
      'IntrestRate':IntrestRate,
      'Tenure':Tenure,
      'Result':Result,

    };
    _ref.push().set({'Principal Amount':"principalAmount",
      'IntrestRate':"IntrestRate",
      'Tenure':"Tenure",
      'Result':"Result"});
  }*/

  Widget loanResultsWidget(loanResult){


    bool canShow = false;
    String _loanResult = loanResult;

    if(_loanResult.length>0){
      canShow = true;
    }

    return

      Container(
          margin: EdgeInsets.only(top: 40.0),
          child: canShow ? Column(
            children: [

              Text("Your monthly home loan is",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),

              Container(
                child:
                Text(_loanResult,
                  style: TextStyle(
                    fontSize: 50.0,

                  ),),
              ),

            ],

          ) : Container()
      );

  }

}

