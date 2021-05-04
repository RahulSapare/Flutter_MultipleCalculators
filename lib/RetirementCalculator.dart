import 'dart:math';

import 'package:coconeobank/configuration.dart';
import 'package:flutter/material.dart';

class RetirementCalculator extends StatefulWidget {
  @override
  _RetirementCalculator createState() => _RetirementCalculator();
}

class _RetirementCalculator extends State<RetirementCalculator> {



  final TextEditingController _currentAge = TextEditingController();
  final TextEditingController _retirementAge = TextEditingController();
  final TextEditingController _lifeExpectancy = TextEditingController();
  final TextEditingController _monthlyExpense = TextEditingController();
  final TextEditingController _currentRetirementCorpus = TextEditingController();
  final TextEditingController _expectedReurnOnInvestment = TextEditingController();
  final TextEditingController _expenseFactor = TextEditingController();

  String _mon_inv="";
  String _ext_corp_need="";

  @override
  Widget build(BuildContext context) {
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


              ///////////////////////////////////
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  onSubmitted: (value){
                    if (value.isEmpty) {
                     return 'Enter a valid password!';
                     }
                    return null;
                      },


                  controller: _currentAge,
                  decoration: InputDecoration(
                      labelText: "Current Age"
                  ),



                  keyboardType: TextInputType.number,
                ),
              ),
              ////////////////////////////////////
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: _retirementAge,
                  decoration: InputDecoration(
                      labelText: "Retirement Age"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              ////////////////////////////////////
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: _lifeExpectancy,
                  decoration: InputDecoration(
                      labelText: "Life Expectancy"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              ////////////////////////////////////

              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: _monthlyExpense,
                  decoration: InputDecoration(
                      labelText: "Monthly Expense"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              ///////////////////////////////////////
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: _currentRetirementCorpus,
                  decoration: InputDecoration(
                      labelText: "Current Retirement Corpus"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              //////////////////////////////////////////
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: _expectedReurnOnInvestment,
                  decoration: InputDecoration(
                      labelText: "Expected Return On Investment"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              /////////////////////////////////////
              Container(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: _expenseFactor,
                  decoration: InputDecoration(
                      labelText: "Expense Factor"
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: FlatButton(

                  onPressed:()=> _handleCalculation(),
                  child: Text("CALCULATE"),
                  color: Colors.amber,
                  textColor: Colors.white,
                  padding: EdgeInsets.only( bottom: 10.0, left: 24.0, right: 24.0),

                ),

              ),

              ResultsWidget(_mon_inv, _ext_corp_need),



            ],
          ),
        ),
      ),



    );
  }

  double FV(rate, nper, pv) {
    var rrate = rate / 100;
    var result = -pv * (pow((1 + rrate), nper));
    return result;
  }

  double PMT(rate, nper, futureValue) {
    var monthlyRate = rate / 100;
    var months = nper;
    var investment = futureValue / ((pow(1 + monthlyRate, months) - 1) / monthlyRate);

    return investment;
  }

  void _handleCalculation(){

    print("pressed");
    print(_currentAge);
    print(_retirementAge);
    var inflation = 6;
    var monthly_inf = 100 * (pow((1 + inflation/100), 1/12) - 1);
    var mon_rate_of_ret = 100 * (pow((1 + double.parse(_expectedReurnOnInvestment.text)/100), 1/12) - 1);
    var real_return_monthly = ((1 + mon_rate_of_ret/100) / (1 + monthly_inf/100) - 1) *100;
    var per_to_ratio = (double.parse(_expenseFactor.text) / 100);
    var post_ret_exp = (double.parse(_monthlyExpense.text) * per_to_ratio);
    var yr_left_for_ret = (double.parse(_retirementAge.text) - double.parse(_currentAge.text));
    var yr_to_live = (double.parse(_lifeExpectancy.text) - double.parse(_currentAge.text));
    var life_exp_months = yr_left_for_ret * 12;
    var exp_at_time_of_ret = FV(monthly_inf, life_exp_months, (post_ret_exp*-1));
    var ret_corp_needed = (exp_at_time_of_ret * 12) * (yr_to_live - yr_left_for_ret);
    var ext_corp_need = FV(real_return_monthly, life_exp_months, (double.parse(_currentRetirementCorpus.text)*-1));
    ext_corp_need = (ret_corp_needed - ext_corp_need);
    var mon_inv = PMT(mon_rate_of_ret, life_exp_months, ext_corp_need);
    print(mon_inv);
    print(ext_corp_need);
    _mon_inv=mon_inv.toString();
    _ext_corp_need=ext_corp_need.toString();
  }

  Widget ResultsWidget(mon_inv,ext_corp_need){


    bool canShow = false;

    String _mon_inv = mon_inv;
    String _ext_corp_need = ext_corp_need;
    print(mon_inv);
    print(ext_corp_need);

    if(_mon_inv.length>0 && _ext_corp_need.length>0){
      canShow = true;
    }


    return

      Container(
          margin: EdgeInsets.only(top: 40.0),
          child: canShow ? Column(
            children: [



              Text("You need to make a monthly investment of\n"+mon_inv+"\n to accumulate a corpus of\n"+   ext_corp_need,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),


            ],

          ) : Container()
      );

  }



}