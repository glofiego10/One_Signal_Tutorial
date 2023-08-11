import 'package:flutter/material.dart';

/// A widget representing Detail Page 1.
class DetailsPage1 extends StatelessWidget {
  /// Creates a Detail Page 1 widget.
  const DetailsPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page 1'),
      ),
      body: const Center(
        child: Text(
          'Navigation with notification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
