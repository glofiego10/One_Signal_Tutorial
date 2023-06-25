import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_signal_tutorial/app/app.dart';
import 'package:one_signal_tutorial/one_signal_repository.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final oneSignalRepository = OneSignalRepository();
  oneSignalRepository.initializeOneSignal();
  runApp(const MainApp());
}
