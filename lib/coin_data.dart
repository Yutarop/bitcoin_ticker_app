import 'package:bitcoin_ticker_app/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String url = 'https://api-realtime.exrates.coinapi.io/v1/exchangerate/BTC/USD?apikey=$API_KEY';

  Future getCoinData() async {
      http.Response response = await http.get(Uri.parse((url)));

      if(response.statusCode == 200){
        String data = response.body;
        var decodedData = jsonDecode(data);
        print(decodedData);
        print(decodedData['rate']);
        return decodedData;
      } else {
        print(response.statusCode);
      }
  }
}

