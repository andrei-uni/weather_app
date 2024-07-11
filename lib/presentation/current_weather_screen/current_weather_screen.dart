import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/domain/models/location.dart';
import 'package:weather_app/presentation/current_weather_screen/app_bar_more_button.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_widget/hourly_weather_widget.dart';
import 'package:weather_app/presentation/my_locations_drawer/my_locations_drawer.dart';
import 'package:weather_app/presentation/widgets/icon_title_widget.dart';
import 'package:weather_app/presentation/widgets/load_failed_widget.dart';
import 'package:weather_app/presentation/widgets/temperature_widget.dart';
import 'package:weather_app/presentation/current_weather_screen/current_weather_bloc/current_weather_bloc.dart';
import 'package:weather_app/presentation/current_weather_screen/weather_metrics_widget/weather_metrics_widget.dart';
import 'package:weather_app/utils/app_router/app_router.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_condition_translator_x.dart';
import 'package:weather_app/utils/extensions/weather_condition_to_asset_x.dart';

@RoutePage()
class CurrentWeatherScreen extends StatelessWidget implements AutoRouteWrapper {
  const CurrentWeatherScreen({
    super.key,
    this.location,
  });

  final Location? location;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentWeatherBloc(
        location: location,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherStateBase>(
        builder: (context, state) {
          switch (state) {
            case CurrentWeatherStateLoadFail(:final errorMessage):
              return Scaffold(
                appBar: AppBar(
                  actions: const [AppBarMoreButton()],
                ),
                drawer: const MyLocationsDrawer(),
                body: LoadFailedWidget(
                  errorMessage: errorMessage,
                  onRetry: () {
                    context.read<CurrentWeatherBloc>().add(LoadWeather());
                  },
                ),
              );
            case CurrentWeatherState():
              break;
          }
          return Scaffold(
            appBar: AppBar(
              title: IconTitleWidget(
                title: state.location.name,
                icon: Icons.location_on,
              ),
              centerTitle: true,
              actions: const [AppBarMoreButton()],
            ),
            drawer: const MyLocationsDrawer(),
            body: Skeletonizer(
              enabled: state.isLoading,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Skeleton.shade(
                        child: Image.asset(
                          state.forecast.weather.weatherCondition.toAsset(),
                        ),
                      ),
                    ),
                  ),
                  TemperatureWidget.large(
                    temperature: state.forecast.weather.temperature,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 15),
                    child: Text(
                      state.forecast.weather.weatherCondition.translate(),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  Skeleton.leaf(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: WeatherMetricsWidget(
                        windSpeed: state.windSpeedString,
                        humidity: state.humidityString,
                        cloudiness: state.cloudinessString,
                      ),
                    ),
                  ),
                  Skeleton.ignore(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          const Text('Today'),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              context.router.push(
                                DailyWeatherRoute(coordinates: state.location.coordinates),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
                            ),
                            iconAlignment: IconAlignment.end,
                            icon: const Icon(Icons.chevron_right),
                            label: const Text('Daily'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HourlyWeatherWidget(
                    pageController: state.hourlyWeatherPageController,
                    itemGetter: state.getHourlyWeatherItems,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
