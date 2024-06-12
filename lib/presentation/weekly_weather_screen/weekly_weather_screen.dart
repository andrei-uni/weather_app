import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/presentation/weekly_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/presentation/widgets/icon_title_widget.dart';
import 'package:weather_app/presentation/weekly_weather_screen/daily_weather_item_widget.dart';
import 'package:weather_app/presentation/weekly_weather_screen/weekly_weather_bloc/weekly_weather_bloc.dart';
import 'package:weather_app/presentation/widgets/load_failed_widget.dart';

@RoutePage()
class WeeklyWeatherScreen extends StatelessWidget implements AutoRouteWrapper {
  const WeeklyWeatherScreen({
    super.key,
    required this.coordinates,
  });

  final Coordinates coordinates;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => WeeklyWeatherBloc(
        coordinates: coordinates,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const IconTitleWidget(
            title: '7 days',
            icon: Icons.calendar_today,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<WeeklyWeatherBloc, WeeklyWeatherState>(
          builder: (context, state) {
            switch (state) {
              case WeatherLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WeatherLoadFail(:final message):
                return LoadFailedWidget(
                  errorMessage: message,
                  onRetry: () {
                    context.read<WeeklyWeatherBloc>().add(LoadWeather());
                  },
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
              ),
            );
          },
        ),
      ),
    );
  }
}
