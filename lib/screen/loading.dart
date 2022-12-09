import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weatherapp/data/my_location.dart';
import 'package:weatherapp/data/network.dart';
import 'package:weatherapp/screen/weather_screen.dart';

const api_key = "ebaaef08c448943a70edc9a42fae2852";

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double latitude3 = 0.0;
  double longtitude3 = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  //내 위치 위도,경도
  void getLocation() async {
    MyLocation mylocation = MyLocation();
    mylocation.getMyCurrentLocation();
    latitude3 = mylocation.latitude2;
    longtitude3 = mylocation.longtitude2;

    NetworkData _networkdata = NetworkData(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$api_key&units=metric");
    var weatherData = await _networkdata.getFetchData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(parsingdata: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {}, child: Text("Get Location")),
      ),
    );
  }
}
