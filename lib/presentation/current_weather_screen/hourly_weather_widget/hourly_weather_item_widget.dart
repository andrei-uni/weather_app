import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/temperature_widget.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_widget/hourly_weather_item_data.dart';
import 'package:weather_app/utils/app_colors.dart';

class HourlyWeatherItemWidget extends StatelessWidget {
  const HourlyWeatherItemWidget({
    super.key,
    required this.itemData,
  });

  final HourlyWeatherItemData itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color:
            itemData.isCurrent ? AppColors.activeBlue(context) : AppColors.containerGrey(context),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TemperatureWidget.small(
            temperature: itemData.temperature,
          ),
          Icon(
            itemData.icon,
            size: 30,
          ),
          const SizedBox(height: 5),
          Text(
            itemData.time,
            style: itemData.isCurrent ? null : const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
