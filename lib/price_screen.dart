import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'const.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  void initState() {
    super.initState();
    coinPrice();
  }

  List<String> coinValues = [];
  String selectedCurrency = 'USD';
  Future<dynamic> coinPrice() async {
    try {
      for (String coin in cryptoList) {
        var priceData = await CoinData().getCoinData(coin, selectedCurrency);
        var longCoinPrice = (priceData['rate']);
        var shortCoinPrice = longCoinPrice.toStringAsFixed(3);
        setState(() {
          coinValues.add(shortCoinPrice);
        });
      }
    } catch (e) {
      print(e.toString());
      for (String cryptos in cryptoList) {
        var error = 'networkError';
        setState(() {
          coinValues.add(error);
        });
      }
    }
  }

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
        setState(() {
          selectedCurrency = value;
          coinValues.clear();
          coinPrice();
          print(selectedCurrency);
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
      backgroundColor: kIospickerBackgroundColor,
      magnification: kIospickerMagnifier,
      useMagnifier: true,
      looping: true,
      children: pickerItems,
      itemExtent: 32.0,
      diameterRatio: 100.0,
      onSelectedItemChanged: (seletedIndex) {
        print(currenciesList[seletedIndex]);
        setState(() {
          selectedCurrency = currenciesList[seletedIndex];
          // btcData();
          // ethData();
          // ltcData();
          coinPrice();
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
        title: kAppBarTitle,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              height: kBodyContainerHeight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
              child: coinValues.length != cryptoList.length
                  ? SpinKitPouringHourglass(
                      color: kSpinKitColor,
                      size: kSpinkitSize,
                    )
                  : ListView.builder(
                      itemCount: cryptoList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 5),
                          child: Card(
                            color: kListCardcolor,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 28.0),
                              child: Text(
                                '${cryptoList[index]}: ${coinValues[index]} $selectedCurrency',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: kListCardTextSize,
                                  color: kListCardTextcolor,
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
          Container(
            height: kBottomContainerSize,
            alignment: kBottomContainerAlignMent,
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
// dynamic btcData() async {
//   var priceData = await CoinData().getCoinData(bitCoin, selectedCurrency);
//   var longBtcPrice = (priceData['rate']);
//   setState(() {
//     btcPrice = longBtcPrice.toStringAsFixed(3);
//   });
// }
//
// dynamic ethData() async {
//   var ethpriceData = await CoinData().getCoinData(etherium, selectedCurrency);
//   var longEthPrice = (ethpriceData['rate']);
//   setState(() {
//     ethPrice = longEthPrice.toStringAsFixed(3);
//   });
// }
//
// dynamic ltcData() async {
//   var ltcpriceData = await CoinData().getCoinData(liteCoin, selectedCurrency);
//   var longLtcPrice = (ltcpriceData['rate']);
//   setState(() {
//     ltcPrice = longLtcPrice.toStringAsFixed(3);
//   });
// }
