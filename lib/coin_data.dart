import 'package:bitcoin_ticker_app/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitcoin_ticker_app/constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'XRP',
  'ADA',
];

class CoinData {
  Future getCoinData(String selectedCurrency,) async {
    // return this map at the end
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList){
      String url = '$baseURL/$crypto/$selectedCurrency?apikey=$API_KEY';
      http.Response response = await http.get(Uri.parse((url)));
      if(response.statusCode == 200){
        var decodedData = jsonDecode(response.body);
          double price = decodedData["rate"].toDouble();
          cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

