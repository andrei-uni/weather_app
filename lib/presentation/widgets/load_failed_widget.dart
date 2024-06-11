import 'package:flutter/material.dart';

class LoadFailedWidget extends StatelessWidget {
  const LoadFailedWidget({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[900],
            size: 80,
          ),
          const Text('Load failed'),
          const SizedBox(height: 5),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
