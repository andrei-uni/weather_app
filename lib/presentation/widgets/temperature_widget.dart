import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget.small({
    super.key,
    required this.temperature,
    this.color,
  })  : temperatureTextStyle = const TextStyle(
          fontSize: 18,
        ),
        degreeSymbolFontSize = 15;

  const TemperatureWidget.medium({
    super.key,
    required this.temperature,
    this.color,
  })  : temperatureTextStyle = const TextStyle(
          fontSize: 22,
        ),
        degreeSymbolFontSize = 18;

  const TemperatureWidget.large({
    super.key,
    required this.temperature,
    this.color,
  })  : temperatureTextStyle = const TextStyle(
          fontSize: 140,
          fontWeight: FontWeight.bold,
          height: 0.95,
        ),
        degreeSymbolFontSize = 40;

  final double temperature;
  final Color? color;
  final TextStyle temperatureTextStyle;
  final double degreeSymbolFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          temperature.toInt().toString(),
          style: temperatureTextStyle.copyWith(
            color: color,
          ),
        ),
        Text(
          '°',
          style: TextStyle(
            fontSize: degreeSymbolFontSize,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
