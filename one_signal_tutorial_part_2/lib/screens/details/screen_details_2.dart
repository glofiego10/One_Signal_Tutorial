import 'package:flutter/material.dart';

/// A widget representing the Detail Page 2.
class DetailsPage2 extends StatelessWidget {
  /// Creates a Detail Page 2 widget.
  ///
  /// The [textNotification] is the text received from the push notification
  /// arguments to be displayed on this page.
  const DetailsPage2({
    super.key,
    required this.textNotification,
  });

  /// The text received from the push notification arguments to be displayed on this page.
  final String textNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page 2'),
      ),
      body: Column(
        children: [
          const Text(
            'Navigation with notification and arguments',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            textNotification,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
