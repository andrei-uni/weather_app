import 'package:flutter/material.dart';

class HourlyWeatherItemData {
  HourlyWeatherItemData({
    required this.temperature,
    required this.iconData,
    required this.time,
    required this.isCurrent,
  });
  
  final double temperature;
  final IconData iconData;
  final String time;
  final bool isCurrent;
}
