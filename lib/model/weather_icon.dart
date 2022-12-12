import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Model {
  Widget? getAirIcon(int? index) {
    if (index == 1) {
      return Image.asset(
        'image/good.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        'image/fair.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 3) {
      return Image.asset(
        'image/moderate.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 4) {
      return Image.asset(
        'image/poor.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 5) {
      return Image.asset(
        'image/bad.png',
        width: 37.0,
        height: 35.0,
      );
    }
  }

  Widget? getAirCondition(int? index) {
    if (index == 1) {
      return Text(
        '"매우좋음"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 2) {
      return Text(
        '"좋음"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 3) {
      return Text(
        '"보통"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 4) {
      return Text(
        '"나쁨"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 5) {
      return Text(
        '"매우나쁨"',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
