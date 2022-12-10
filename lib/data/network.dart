import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkData {
  String url = "";
  String url2 = "";
  NetworkData(this.url, this.url2);

  Future<dynamic> getFetchData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String _jsondata = response.body;
      var parsingData = jsonDecode(_jsondata);
      return parsingData;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getPollutionData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String _jsondata = response.body;
      var parsingData2 = jsonDecode(_jsondata);
      return parsingData2;
    } else {
      print(response.statusCode);
    }
  }
}
