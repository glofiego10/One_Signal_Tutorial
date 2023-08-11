import 'package:flutter/material.dart';
import 'package:one_signal_tutorial/app/routes/router.dart';
import 'package:one_signal_tutorial/app/routes/router.gr.dart';
import 'package:one_signal_tutorial/data/models/push_notification_data.model.dart';
import 'package:one_signal_tutorial/domain/one_signal_repository.dart';
import 'package:one_signal_tutorial/utils/push_notification_helper.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// The main application widget.
class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // The router for navigating between pages.
  final _router = AppRouter();

  /// The handler for when a notification is opened.
  final _openHandler = OneSignalRepository().notificationOpenedHandler;

  @override
  void initState() {
    super.initState();
    _setupNotificationHandler();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.config(),
    );
  }

  /// Sets up the handler for when a notification is opened or a button is pushed.
  void _setupNotificationHandler() {
    _openHandler((OSNotificationOpenedResult result) {
      var payload = result.notification.additionalData;
      var actionId = result.action?.actionId;

      if (actionId != null && payload != null) {
        var data = PushNotificationData.fromJson(payload);
        _handleAction(data, actionId);
        return;
      }

      if (actionId != null) {
        _handleAction(null, actionId);
        return;
      }

      if (payload != null) {
        var data = PushNotificationData.fromJson(payload);
        _handleNotificationOpen(data);
      }
    });
  }

  /// Handles the opening of a notification.
  void _handleNotificationOpen(PushNotificationData data) {
    if (data.redirect) {
      var args = PushNotificationHelper.getArgumentsByTypeForRouterNavigation(
        data.argsType!,
        data.args,
      );

      switch (data.path) {
        case DetailsRoute1.name:
          _router.navigate(const DetailsRoute1());
          break;
        case DetailsRoute2.name:
          _router.navigate(DetailsRoute2(textNotification: args));
          break;
        default:
          break;
      }
    }
  }

  /// Handles the actions of buttons in notifications.
  void _handleAction(PushNotificationData? data, String actionId) {
    switch (actionId) {
      case 'button1':
        _router.navigate(const DetailsRoute1());
        return;
      case 'button2':
        if (data != null && data.redirect) {
          var args =
              PushNotificationHelper.getArgumentsByTypeForRouterNavigation(
            data.argsType!,
            data.args,
          );
          _router.navigate(DetailsRoute2(textNotification: args));
          return;
        }
        _router.navigate(
          DetailsRoute2(
            textNotification: 'Action Button 2 Pressed without payload',
          ),
        );
        return;
      default:
        return;
    }
  }
}
