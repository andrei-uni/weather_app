import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/presentation/weekly_weather_screen/weekly_weather_screen.dart';
import 'package:weather_app/presentation/widgets/title_widget.dart';
import 'package:weather_app/presentation/weather_screen/hourly_weather_item_widget.dart';
import 'package:weather_app/presentation/widgets/temperature_widget.dart';
import 'package:weather_app/presentation/weather_screen/hourly_weather_item_data.dart';
import 'package:weather_app/presentation/weather_screen/weather_bloc/weather_bloc.dart';
import 'package:weather_app/presentation/weather_screen/weather_metrics_widget.dart';
import 'package:weather_app/utils/translation_helper_extensions/weather_condition_translator_x.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => WeatherBloc(
          latitude: latitude,
          longitude: longitude,
        ),
        child: BlocBuilder<WeatherBloc, WeatherState>(
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
            return Scaffold(
              appBar: AppBar(
                title: TitleWidget(
                  title: state.forecast.location.city,
                  icon: Icons.location_on,
                ),
                centerTitle: true,
                actions: [
                  SubmenuButton(
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {},
                        child: const Text('Change Location'),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        child: const Text('Exit'),
                      ),
                    ],
                    child: const Icon(
                      Icons.more_vert,
                      size: 30,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  FlutterLogo(
                    size: MediaQuery.sizeOf(context).width * 0.7,
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
                          onPressed: () => _goToWeeklyWeather(context),
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
      ),
    );
  }

  void _goToWeeklyWeather(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeeklyWeatherScreen(
          latitude: latitude,
          longitude: longitude,
        ),
      ),
    );
  }
}
