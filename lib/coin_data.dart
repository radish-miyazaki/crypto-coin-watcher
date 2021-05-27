import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

var apiKey = env['COIN_API_KEY'];

var coinAPIURL = env['COIN_API_URI'];

class CoinData {
  Future getCoinData(String currency) async {
    var lastPrices = [];
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';

      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodeData = convert.jsonDecode(response.body);
        var lastPrice = decodeData['rate'];
        lastPrices.add(lastPrice);
      } else {
        print(response.statusCode);
        throw 'Error: cannot get coin data';
      }
    }
    return lastPrices;
  }
}
