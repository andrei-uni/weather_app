import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
      child: BlocBuilder<DailyWeatherBloc, DailyWeatherStateBase>(
        builder: (context, state) {
          switch (state) {
            case DailyWeatherStateLoadFail(:final errorMessage):
              return Scaffold(
                body: LoadFailedWidget(
                  errorMessage: errorMessage,
                  onRetry: () {
                    context.read<DailyWeatherBloc>().add(LoadWeather());
                  },
                ),
              );
            case DailyWeatherState():
              break;
          }
          return Scaffold(
            appBar: AppBar(
              title: IconTitleWidget(
                title: '${state.days} days',
                icon: Icons.calendar_today,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Skeletonizer(
                enabled: state.isLoading,
                child: Column(
                  children: [
                    for (final DailyWeatherItemData data in state.dailyWeatherItems)
                      DailyWeatherItemWidget(data: data),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
