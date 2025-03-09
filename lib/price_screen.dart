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
  int? selectedExchangeRateBTC;
  int? selectedExchangeRateETH;
  int? selectedExchangeRateLTC;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  void getExchangeRate() async{
    CoinData coinData = CoinData();
    var btcData = await coinData.getCoinData(selectedCurrency, 'BTC');
    var ethData = await coinData.getCoinData(selectedCurrency, 'ETH');
    var ltcData = await coinData.getCoinData(selectedCurrency, 'LTC');
    setState(() {
      selectedExchangeRateBTC = btcData['rate'].toInt();
      selectedExchangeRateETH = ethData['rate'].toInt();
      selectedExchangeRateLTC = ltcData['rate'].toInt();
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
          selectedCurrency = value!;
          getExchangeRate();
          print(selectedCurrency);
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
        title: Center(child: Text('🤑 Coin Ticker')),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $selectedExchangeRateBTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $selectedExchangeRateETH $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $selectedExchangeRateLTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
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
