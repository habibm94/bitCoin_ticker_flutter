import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final dynamic url;
  NetworkHelper(this.url);
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic data = response.body;
      dynamic decodedData = jsonDecode(data);
      return decodedData;
    } else if (response.statusCode == 400) {
      print(
          'Status code 400: Bad Request -- There is something wrong with your request');
    } else if (response.statusCode == 401) {
      print('Status code 401: Unauthorized -- Your API key is wrong');
    } else if (response.statusCode == 429) {
      print(
          'Status code 429:Too many requests -- You have exceeded your API key rate limits');
    } else if (response.statusCode == 403) {
      print(
          'Status code 403: Forbidden -- Your API key does not have enough privileges to access this resource');
    } else {
      print(response.statusCode.toString());
    }
  }
}
