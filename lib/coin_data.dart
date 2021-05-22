import 'networkHelper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'BDT',
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
];

//class to fetch crypto data through network helper and return it
class CoinData {
  // final dynamic curreny;
  // CoinData(this.curreny);
  Future<dynamic> getCoinData(String coinName, String currency) async {
    NetworkHelper coinDatafetcher = await NetworkHelper(
        'https://rest.coinapi.io/v1/exchangerate/$coinName/$currency?apikey=67DB06A8-EAA4-4F8A-93E8-67C7D1C08146');
    dynamic coinPrice = coinDatafetcher.getData();
    return coinPrice;
  }
}
