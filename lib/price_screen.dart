import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker_app/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String? selectedCurrency = 'USD';
  int? trialData;
  String? textTry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBTCExchangeRate();
  }

  void getBTCExchangeRate() async{
    CoinData coinData = CoinData();
    var rawData = await coinData.getCoinData();
    trialData = rawData['rate'].toInt();
    print('look at $trialData');
    setState(() {
      textTry = '1 BTC = $trialData USD';
    });
  }

  DropdownButton<String> androidDropdownButton(){
    List<DropdownMenuItem<String>> dropdownItems = [];
    for(String currencyName in currenciesList){
      var newItem = DropdownMenuItem(
        child: Text(currencyName),
        value: currencyName,
      );
      dropdownItems.add(newItem);
    };

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      }
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> textItems = [];
    for(String currencyName in currenciesList){
      var newItem = Text(
        currencyName,
      );
      textItems.add(newItem);
    };

    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      }, children: textItems,
    );
  }

  Widget getPicker(){
    if (Platform.isIOS) {
      return iOSPicker();
    }
    else if (Platform.isAndroid) {
      return androidDropdownButton();
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  textTry ?? '?',
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
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          //   Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
