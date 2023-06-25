import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Class to handle OneSignal API
class OneSignalRepository {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /// Initialization of services
  Future<void> initializeOneSignal() async {
    // Set the OneSignal app ID using dotenv
    await OneSignal.shared.setAppId(dotenv.get('ONESIGNAL_APP_ID'));

    // Initialize FlutterLocalNotificationsPlugin
    initializeFlutterLocalNotifications();

    // Prompt the user for push notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission();

    // Create an AndroidNotificationChannel for high importance notifications
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // Create the notification channel using the AndroidFlutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Set up the notification will show in foreground handler
    setupNotificationWillShowInForegroundHandler();

    // Set up the notification opened handler
    setupNotificationOpenedHandler();
  }

  /// Initialize FlutterLocalNotificationsPlugin
  void initializeFlutterLocalNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /// Set up the notification will show in foreground handler
  ///
  /// When the notification arrives in the foreground,
  /// we can utilize the FlutterLocalNotificationsPlugin
  /// to provide a more customized experience for the user.
  /// However, the approach can be adjusted based on your specific requirements.
  /// If you prefer to keep the handling consistent regardless of the app's state,
  /// you can remove the showLocalNotification(event.notification) method call and
  /// retain only event.complete(event.notification).
  void setupNotificationWillShowInForegroundHandler() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) async {
        showLocalNotification(event.notification);
        event.complete(null);
      },
    );
  }

  /// Show a local notification using FlutterLocalNotificationsPlugin
  void showLocalNotification(OSNotification notification) async {
    final android = notification.smallIcon;
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.high,
          icon: android,
        ),
      ),
    );
  }

  /// The notification opened handler is called whenever
  /// the user opens a OneSignal push notification
  void setupNotificationOpenedHandler() {
    OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult result) {
        debugPrint('Notificacion tapeada');
      },
    );
  }

  /// Get the user's token ID
  Future<String?> getUserTokenId() async {
    final deviceState = await OneSignal.shared.getDeviceState();
    final tokenId = deviceState!.userId;
    return tokenId;
  }

  /// Function to send a simple notification to a list of users
  /// as well as a single user.
  Future<void> sendNotificationToUsers({
    required List<String> tokenIds,
    required String title,
    required String description,
  }) async {
    final notification = OSCreateNotification(
      playerIds: tokenIds,
      content: description,
      heading: title,
    );
    await OneSignal.shared.postNotification(notification);
  }
}
