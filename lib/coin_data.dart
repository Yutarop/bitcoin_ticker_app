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
];

class CoinData {

  Future getCoinData(String selectedCurrency, String selectedCrypt) async {
      String url = '$baseURL/$selectedCrypt/$selectedCurrency?apikey=$API_KEY';
      http.Response response = await http.get(Uri.parse((url)));

      if(response.statusCode == 200){
        String data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        print(response.statusCode);
      }
  }
}

