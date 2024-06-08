import 'package:weather_app/domain/models/weekday.dart';

extension WeekdayTranslatorX on Weekday {
  String translateShort() {
    return switch (this) {
      Weekday.monday => 'Mon',
      Weekday.tuesday => 'Tue',
      Weekday.wednesday => 'Wed',
      Weekday.thursday => 'Thu',
      Weekday.friday => 'Fri',
      Weekday.saturday => 'Sat',
      Weekday.sunday => 'Sun',
    };
  }
}