import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_signal_tutorial/app/app.dart';
import 'package:one_signal_tutorial/domain/one_signal_repository.dart';

void main() async {
  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");

  // Initialize the OneSignal repository
  final oneSignalRepository = OneSignalRepository();
  await oneSignalRepository.initializeOneSignal();

  // Run the main app
  runApp(const MainApp());
}
