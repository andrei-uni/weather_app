import 'package:flutter/material.dart';

class LoadFailedWidget extends StatelessWidget {
  const LoadFailedWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade900,
            size: 80,
          ),
          Text(errorMessage),
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
