import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_widget/hourly_weather_item_data.dart';
import 'package:weather_app/presentation/current_weather_screen/hourly_weather_widget/hourly_weather_item_widget.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({
    super.key,
    required this.pageController,
    required this.itemGetter,
  });

  final PageController pageController;
  final List<HourlyWeatherItemData> Function(int pageIndex) itemGetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: pageController,
            itemCount: 6,
            itemBuilder: (context, index) {
              final List<HourlyWeatherItemData> itemDatas = itemGetter(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (final data in itemDatas)
                    HourlyWeatherItemWidget(itemData: data),
                ],
              );
            },
          ),
        ),
        Skeleton.ignore(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: SmoothPageIndicator(
              controller: pageController,
              count: 6,
              effect: WormEffect(
                dotWidth: 7,
                dotHeight: 7,
                activeDotColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
