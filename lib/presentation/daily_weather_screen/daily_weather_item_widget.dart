import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/presentation/daily_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/presentation/widgets/temperature_widget.dart';

class DailyWeatherItemWidget extends StatelessWidget {
  const DailyWeatherItemWidget({
    super.key,
    required this.data,
  });

  final DailyWeatherItemData data;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: Text(
              data.label,
              style: textStyle?.copyWith(color: Colors.grey),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Skeleton.shade(
                child: Icon(
                  data.icon,
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                data.condition,
                style: textStyle,
              ),
            ],
          ),
          const Spacer(),
          Skeleton.unite(
            child: Row(
              children: [
                TemperatureWidget.medium(
                  temperature: data.dayTemp,
                ),
                const SizedBox(width: 8),
                TemperatureWidget.medium(
                  temperature: data.nightTemp,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
