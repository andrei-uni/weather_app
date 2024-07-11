import 'package:flutter/material.dart';

class IconTitleWidget extends StatelessWidget {
  const IconTitleWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          const SizedBox(width: 7),
          Text(
            title,
            softWrap: false,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
