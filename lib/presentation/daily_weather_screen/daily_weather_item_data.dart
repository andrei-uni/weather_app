import 'package:flutter/material.dart';

class DailyWeatherItemData {
  const DailyWeatherItemData({
    required this.label,
    required this.iconData,
    required this.condition,
    required this.dayTemp,
    required this.nightTemp,
  });
  
  final String label;
  final IconData iconData;
  final String condition;
  final double dayTemp;
  final double nightTemp;
}