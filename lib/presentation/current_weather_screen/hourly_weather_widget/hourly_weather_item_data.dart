import 'package:flutter/material.dart';

class HourlyWeatherItemData {
  HourlyWeatherItemData({
    required this.temperature,
    required this.icon,
    required this.time,
    required this.isCurrent,
  });
  
  final double temperature;
  final IconData icon;
  final String time;
  final bool isCurrent;
}
