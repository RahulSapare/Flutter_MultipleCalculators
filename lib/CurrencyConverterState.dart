import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'configuration.dart';

class _CurrencyConverterState extends State<CurrencyConverter> {
  final fromTextController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "GBP";
  String result;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<String> _loadCurrencies() async {
    String uri = "https://api.exchangeratesapi.io/latest";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    print(currencies);
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri = "https://api.exchangeratesapi.io/latest?base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(fromTextController.text) * (responseBody["rates"][toCurrency])).toString();
    });
    print(result);
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      toCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.amber, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text("Currency Converter", style: TextStyle(color: primarycolor, fontSize: 20),),
        elevation: 0.0,

      ),
      body: currencies == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: TextField(
                    controller: fromTextController,
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                  ),
                  trailing: _buildDropDownButton(fromCurrency),
                ),

                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.amber,
                  child: IconButton(
                    icon: Icon(
                      Icons.swap_vert,
                      color: Colors.black,
                    ),
                    onPressed: _doConversion,
                  ),
                ),

                //IconButton(
                // icon: Icon(Icons.swap_vert),

                // color: Colors.amber,
                // onPressed: _doConversion,
                // ),
                ListTile(
                  title: Chip(
                    label: result != null ?
                    Text(
                      result,
                      style: Theme.of(context).textTheme.display1,
                    ) : Text(""),
                  ),
                  trailing: _buildDropDownButton(toCurrency),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currencies
          .map((String value) => DropdownMenuItem(
        value: value,
        child: Row(
          children: <Widget>[
            Text(value),
          ],
        ),
      ))
          .toList(),
      onChanged: (String value) {
        if(currencyCategory == fromCurrency){
          _onFromChanged(value);
        }else {
          _onToChanged(value);
        }
      },
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

