import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkData {
  String url;
  String url2;
  String url3;

  NetworkData(this.url, this.url2, this.url3);

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
      var _jsondata = response.body;
      var parsingData2 = jsonDecode(_jsondata);
      return parsingData2;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getForecastData() async {
    http.Response response = await http.get(Uri.parse(url3));
    if (response.statusCode == 200) {
      var _jsondata = response.body;
      var parsingData3 = jsonDecode(_jsondata);
      return parsingData3;
    } else {
      print(response.statusCode);
    }
  }
}
