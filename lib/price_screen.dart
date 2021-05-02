import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
//android dropdown button
  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> DropdownItem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      DropdownItem.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: DropdownItem,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

//ios picker
  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.white30,
      magnification: 1.5,
      useMagnifier: true,
      looping: true,
      children: pickerItems,
      itemExtent: 32.0,
      diameterRatio: 100.0,
      onSelectedItemChanged: (seletedIndex) {
        print(currenciesList[seletedIndex]);
        setState(() {
          selectedCurrency = currenciesList[seletedIndex];
        });
      },
    );
  }

//on platsform picker/dropdownbutton selector
  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return androidDropdownButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '$selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            // padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blueAccent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: getPicker(),
            ),
          ),
        ],
      ),
    );
  }
}
