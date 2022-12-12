import 'package:flutter/material.dart';
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
  double? latitude3;
  double? longtitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  //내 위치 위도,경도
  void getLocation() async {
    MyLocation mylocation = MyLocation();
    await mylocation.getMyCurrentLocation();
    latitude3 = mylocation.latitude2;
    longtitude3 = mylocation.longtitude2;

    NetworkData _networkdata = NetworkData(
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude3}&lon=${longtitude3}&appid=$api_key&units=metric",
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=${latitude3}&lon=${longtitude3}&appid=$api_key",
        "https://api.openweathermap.org/data/2.5/forecast?lat=${latitude3}&lon=${longtitude3}&appid=$api_key");
    var weatherData = await _networkdata.getFetchData();
    var pollutionData = await _networkdata.getPollutionData();
    var forecastData = await _networkdata.getForecastData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parsingdata: weatherData,
        parsingdata2: pollutionData,
        parsingdata3: forecastData,
      );
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
