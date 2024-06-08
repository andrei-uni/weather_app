import 'package:flutter/material.dart';
import 'package:weather_app/presentation/weather_screen/weather_metric_item.dart';

class WeatherMetricsWidget extends StatelessWidget {
  const WeatherMetricsWidget({
    super.key,
    required this.windSpeed,
    required this.humidity,
    required this.cloudiness,
  });

  final String windSpeed;
  final String humidity;
  final String cloudiness;

  @override
  Widget build(BuildContext context) {
    const verticalDivider = VerticalDivider(
      indent: 13,
      endIndent: 13,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF202328),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: WeatherMetricItem(
                iconData: Icons.thunderstorm,
                metric: windSpeed,
                label: 'Wind',
              ),
            ),
            verticalDivider,
            Expanded(
              child: WeatherMetricItem(
                iconData: Icons.water_drop,
                metric: humidity,
                label: 'Humidity',
              ),
            ),
            verticalDivider,
            Expanded(
              child: WeatherMetricItem(
                iconData: Icons.cloud,
                metric: cloudiness,
                label: 'Clouds',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
