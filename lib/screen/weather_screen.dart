import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.parsingdata});

  final parsingdata;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    // loading에서 데이터를 받아와서 업데이트
    updataWeather(widget.parsingdata);
  }

  //변수 initialize
  String _name = "";
  double _temp = 0.0;

  // parsingdata에서 받아온 데이터로 업데이트
  void updataWeather(dynamic weatherData) {
    _name = weatherData['name'];
    _temp = weatherData['main']['temp'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("날씨앱"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _name,
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            _temp.toString(),
            style: TextStyle(fontSize: 20.0),
          )
        ],
      )),
    );
  }
}
