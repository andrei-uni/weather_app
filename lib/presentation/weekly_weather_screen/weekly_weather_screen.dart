import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/weekly_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/presentation/widgets/title_widget.dart';
import 'package:weather_app/presentation/weekly_weather_screen/daily_weather_item_widget.dart';
import 'package:weather_app/presentation/weekly_weather_screen/weekly_weather_bloc/weekly_weather_bloc.dart';

class WeeklyWeatherScreen extends StatelessWidget {
  const WeeklyWeatherScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const TitleWidget(
            title: '7 days',
            icon: Icons.calendar_today,
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => WeeklyWeatherBloc(
            latitude: latitude,
            longitude: longitude,
          ),
          child: BlocBuilder<WeeklyWeatherBloc, WeeklyWeatherState>(
            builder: (context, state) {
              switch (state) {
                case WeatherLoading():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case WeatherLoadFail():
                  return const Center(
                    child: Text('Load Failed'),
                  );
                case WeatherLoadSuccess():
                  break;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    for (final DailyWeatherItemData data in state.dailyWeatherItems)
                      DailyWeatherItemWidget(data: data),
                  ],
                  // children: [
                  //   DailyWeatherItemWidget(
                  //     label: 'Mon',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 20,
                  //     nightTemp: 14,
                  //   ),
                  //   DailyWeatherItemWidget(
                  //     label: 'Tue',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 22,
                  //     nightTemp: 16,
                  //   ),
                  //   DailyWeatherItemWidget(
                  //     label: 'Wed',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 19,
                  //     nightTemp: 13,
                  //   ),
                  //   DailyWeatherItemWidget(
                  //     label: 'Thu',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 18,
                  //     nightTemp: 12,
                  //   ),
                  //   DailyWeatherItemWidget(
                  //     label: 'Fri',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 23,
                  //     nightTemp: 19,
                  //   ),
                  //   DailyWeatherItemWidget(
                  //     label: 'Sat',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 25,
                  //     nightTemp: 17,
                  //   ),
                  //   DailyWeatherItemWidget(
                  //     label: 'Sun',
                  //     iconData: Icons.cloud,
                  //     condition: 'Cloudy',
                  //     dayTemp: 21,
                  //     nightTemp: 18,
                  //   ),
                  // ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
