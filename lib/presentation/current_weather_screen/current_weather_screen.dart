import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/domain/models/coordinates.dart';
import 'package:weather_app/presentation/current_weather_screen/app_bar_more_button.dart';
import 'package:weather_app/presentation/widgets/icon_title_widget.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_item_widget.dart';
import 'package:weather_app/presentation/widgets/load_failed_widget.dart';
import 'package:weather_app/presentation/widgets/temperature_widget.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_item_data.dart';
import 'package:weather_app/presentation/current_weather_screen/current_weather_bloc/current_weather_bloc.dart';
import 'package:weather_app/presentation/current_weather_screen/weather_metrics_widget.dart';
import 'package:weather_app/utils/app_router/app_router.dart';
import 'package:weather_app/utils/extensions/translation_helper_extensions/weather_condition_translator_x.dart';
import 'package:weather_app/utils/extensions/weather_condition_to_asset_x.dart';

@RoutePage()
class CurrentWeatherScreen extends StatelessWidget implements AutoRouteWrapper {
  const CurrentWeatherScreen({
    super.key,
    this.coordinates,
  });

  final Coordinates? coordinates;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentWeatherBloc(
        coordinates: coordinates,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          switch (state) {
            case WeatherLoading():
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case WeatherLoadFail(:final message):
              return Scaffold(
                appBar: AppBar(
                  actions: const [AppBarMoreButton()],
                ),
                body: LoadFailedWidget(
                  errorMessage: message,
                  onRetry: () {
                    context.read<CurrentWeatherBloc>().add(LoadWeather());
                  },
                ),
              );
            case WeatherLoadSuccess():
              break;
          }
          return Scaffold(
            appBar: AppBar(
              title: IconTitleWidget(
                title: state.forecast.location.city,
                icon: Icons.location_on,
              ),
              centerTitle: true,
              actions: const [AppBarMoreButton()],
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      state.forecast.currentWeather.weatherCondition.toAsset(),
                    ),
                  ),
                ),
                TemperatureWidget.large(
                  temperature: state.forecast.currentWeather.temperature,
                ),
                Text(
                  state.forecast.currentWeather.weatherCondition.translate(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: WeatherMetricsWidget(
                    windSpeed: state.windSpeedString,
                    humidity: state.humidityString,
                    cloudiness: state.cloudinessString,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text('Today'),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          context.router.push(WeeklyWeatherRoute(coordinates: state.coordinates!));
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
                        ),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.chevron_right),
                        label: const Text('7 days'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: state.hourlyWeatherPageController,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final itemDatas = state.getHourlyWeather(index);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (final HourlyWeatherItemData data in itemDatas)
                            HourlyWeatherItemWidget(itemData: data),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: SmoothPageIndicator(
                    controller: state.hourlyWeatherPageController,
                    count: 6,
                    effect: WormEffect(
                      dotWidth: 7,
                      dotHeight: 7,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
