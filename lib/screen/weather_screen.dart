import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weatherapp/model/weather_icon.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
    required this.parsingdata,
    required this.parsingdata2,
  });

  final parsingdata;
  final parsingdata2;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    // loading에서 데이터를 받아와서 업데이트
    updataWeather(widget.parsingdata, widget.parsingdata2);
  }

  //변수 initialize
  Model model = Model();
  String? _name;
  String? _desc;
  SvgPicture? icon;
  Widget? image;
  Widget? text;
  double? air;
  double? air2;
  int? current_temp;
  int temp = 0;
  var date = DateTime.now();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool darkmode = false;

  // parsingdata에서 받아온 데이터로 업데이트
  void updataWeather(dynamic weatherData, dynamic pollutionData) {
    _name = weatherData['name'];
    _desc = weatherData['weather'][0]['description'];
    var grade = pollutionData['list'][0]['main']['aqi'];
    var index = pollutionData['list'][0]['main']['aqi'];
    int condition = weatherData['weather'][0]['id'];
    double _temp = weatherData['main']['temp'].toDouble();
    air = pollutionData['list'][0]['components']['pm2_5'];
    air2 = pollutionData['list'][0]['components']['pm10'];
    temp = _temp.round();
    icon = model.getWeatherIcon(condition);
    image = model.getAirIcon(index);
    text = model.getAirCondition(grade);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  // refresh button
  Future<void> _refresh() {
    updataWeather(widget.parsingdata, widget.parsingdata2);
    return Future<void>.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
              icon: Icon(Icons.refresh)),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    darkmode = !darkmode;
                  });
                },
                icon: Icon(Icons.dark_mode))
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: Container(
            child: Stack(
              children: [
                darkmode == false
                    ? Image.asset(
                        'image/background.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Image.asset(
                        'image/background_black.jpeg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  _name!,
                                  style: GoogleFonts.lato(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    // 시간
                                    TimerBuilder.periodic(Duration(minutes: 1),
                                        builder: (context) {
                                      print("{$getSystemTime()}");
                                      return Text(
                                        "${getSystemTime()}",
                                        style: GoogleFonts.lato(
                                            fontSize: 16, color: Colors.white),
                                      );
                                    }),
                                    Text(
                                      DateFormat('- EEEE').format(date),
                                      style: GoogleFonts.lato(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat(',d MMM, yyy').format(date),
                                      style: GoogleFonts.lato(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${temp.toString()}\u2103",
                                  style: GoogleFonts.lato(
                                      fontSize: 85,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    icon!,
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _desc!,
                                      style: GoogleFonts.lato(
                                          fontSize: 16, color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Divider(
                            height: 15.0,
                            thickness: 2.0,
                            color: Colors.white30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "AOI(대기질지수)",
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  image!,
                                  SizedBox(
                                    height: 10,
                                  ),
                                  text!,
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "미세먼지",
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "$air",
                                    style: GoogleFonts.lato(
                                        fontSize: 35,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "㎍/m3",
                                    style: GoogleFonts.lato(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "초미세먼지",
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "$air2",
                                    style: GoogleFonts.lato(
                                        fontSize: 35,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "㎍/m3",
                                    style: GoogleFonts.lato(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
