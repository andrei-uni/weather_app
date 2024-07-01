import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/presentation/daily_weather_screen/daily_weather_item_data.dart';
import 'package:weather_app/presentation/widgets/icon_title_widget.dart';
import 'package:weather_app/presentation/daily_weather_screen/daily_weather_item_widget.dart';
import 'package:weather_app/presentation/daily_weather_screen/daily_weather_bloc/daily_weather_bloc.dart';
import 'package:weather_app/presentation/widgets/load_failed_widget.dart';

@RoutePage()
class DailyWeatherScreen extends StatelessWidget implements AutoRouteWrapper {
  const DailyWeatherScreen({
    super.key,
    required this.coordinates,
  });

  final Coordinates coordinates;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyWeatherBloc(
        coordinates: coordinates,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DailyWeatherBloc, DailyWeatherState>(
        builder: (context, state) {
          switch (state) {
            case WeatherLoading():
              return Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case WeatherLoadFail(:final message):
              return Scaffold(
                body: LoadFailedWidget(
                  errorMessage: message,
                  onRetry: () {
                    context.read<DailyWeatherBloc>().add(LoadWeather());
                  },
                ),
              );
            case WeatherLoadSuccess():
              break;
          }
          return Scaffold(
            appBar: AppBar(
              title: IconTitleWidget(
                title: '${state.dailyWeather.length} days',
                icon: Icons.calendar_today,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  for (final DailyWeatherItemData data in state.dailyWeatherItems)
                    DailyWeatherItemWidget(data: data),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
