import 'package:flutter/material.dart';

class WeatherMetricItem extends StatelessWidget {
  const WeatherMetricItem({
    super.key,
    required this.icon,
    required this.metric,
    required this.label,
  });

  final IconData icon;
  final String metric;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
        ),
        const SizedBox(height: 5),
        Text(
          metric,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            height: 0.9,
          ),
        ),
      ],
    );
  }
}
