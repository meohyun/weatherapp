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
  int? temp;
  int? sun_rise;
  int? sun_set;
  var sunset;
  var sunrise;
  double? wind_speed;

  var date = DateTime.now();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool darkmode = false;

  // parsingdata에서 받아온 데이터로 업데이트
  void updataWeather(dynamic weatherData, dynamic pollutionData) {
    print(weatherData);
    _name = weatherData['name'];
    _desc = weatherData['weather'][0]['description'];
    var grade = pollutionData['list'][0]['main']['aqi'];
    var index = pollutionData['list'][0]['main']['aqi'];
    int condition = weatherData['weather'][0]['id'];
    double _temp = weatherData['main']['temp'].toDouble();
    wind_speed = weatherData['wind']['speed'];
    sun_rise = weatherData['sys']['sunrise'];
    sun_set = weatherData['sys']['sunset'];
    sunrise =
        DateTime.fromMillisecondsSinceEpoch(sun_rise! * 1000).toUtc().toLocal();
    sunset =
        DateTime.fromMillisecondsSinceEpoch(sun_set! * 1000).toUtc().toLocal();
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
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    // 시간
                                    Text(
                                      DateFormat('yyy, MMM ,d').format(date),
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      DateFormat(',EEEE').format(date),
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    TimerBuilder.periodic(Duration(minutes: 1),
                                        builder: (context) {
                                      print("{$getSystemTime()}");
                                      return Text(
                                        "  ${getSystemTime()}",
                                        style: GoogleFonts.lato(
                                            fontSize: 20, color: Colors.white),
                                      );
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  _name!,
                                  style: GoogleFonts.lato(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'image/sun_rise.png',
                                            width: 37.0,
                                            height: 35.0,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DateFormat('HH : MM')
                                                .format(sunrise),
                                            style: GoogleFonts.lato(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'image/sun_rise.png',
                                            width: 37.0,
                                            height: 35.0,
                                            color: Colors.white60,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            DateFormat('HH : MM')
                                                .format(sunset),
                                            style: GoogleFonts.lato(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat_sharp,
                                      size: 70,
                                      color: Colors.redAccent,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        "${temp.toString()}\u2103",
                                        style: GoogleFonts.lato(
                                            fontSize: 70,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.wind_power_rounded,
                                          size: 50,
                                          color: Colors.blue[200],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          "${wind_speed.toString()}m/s",
                                          style: GoogleFonts.lato(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [
                                      icon!,
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          _desc!,
                                          style: GoogleFonts.lato(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
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
