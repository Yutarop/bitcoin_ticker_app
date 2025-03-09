import 'package:bitcoin_ticker_app/cryptoCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker_app/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  Map<String, String> coinValues = {};
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Column makeCards(){
    List<Widget> cryptoCards = [];
    for (int i = 0; i < cryptoList.length; i++) {
      if (i != 0) {
        cryptoCards.add(
          SizedBox(
            height: 20.0,
          )
        );
      }
      cryptoCards.add(
        Cryptocard(
          cryptoCurrency: cryptoList[i],
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[cryptoList[i]],
        )
      );
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
    children: cryptoCards,
    );
  }

  void getExchangeRate() async{
    isWaiting = true;
    CoinData coinData = CoinData();
    try {
      var data = await coinData.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
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
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
      ),
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getExchangeRate();
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
        selectedCurrency = currenciesList[selectedIndex];
        getExchangeRate();
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
        title: Center(child: Text(
          '🤑 Coin Ticker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Color(0xFF388E3C),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: makeCards(),
          ),
          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 10.0),
            color: Color(0xFF3D8D7A),
            child: getPicker(),
          //   Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
