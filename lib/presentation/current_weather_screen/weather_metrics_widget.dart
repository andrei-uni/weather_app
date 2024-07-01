import 'package:flutter/material.dart';
import 'package:weather_app/presentation/current_weather_screen/weather_metric_item.dart';
import 'package:weather_app/utils/app_colors.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.containerGrey(context),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: WeatherMetricItem(
                iconData: Icons.air,
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
