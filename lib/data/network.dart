import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkData {
  String url = "";
  NetworkData(this.url);

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
}
