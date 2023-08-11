import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_signal_tutorial/data/models/models.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

/// A repository class to handle interactions with the OneSignal API for push notifications.
class OneSignalRepository {
  /// Initializes the OneSignal SDK and requests push notification permissions.
  /// Make sure to set the 'ONESIGNAL_APP_ID' in your '.env' file before calling this method.
  /// This method must be called once when the app starts to enable push notifications.
  /// If the user has already granted permission, this will not show any dialogs.
  ///
  /// Example usage:
  /// ```dart
  /// await OneSignalRepository().initializeOneSignal();
  /// ```
  Future<void> initializeOneSignal() async {
    // Set the OneSignal app ID using dotenv
    await OneSignal.shared.setAppId(dotenv.get('ONESIGNAL_APP_ID'));

    // Prompt the user for push notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission();

    // Set up the notification will show in foreground handler
    _setupNotificationWillShowInForegroundHandler();
  }

  /// Sets up the notification handler when a notification arrives in the foreground.
  /// By default, the notification will be shown as it is.
  /// If you prefer to handle the notification differently when the app is in the foreground,
  /// customize the logic inside this method.
  void _setupNotificationWillShowInForegroundHandler() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) async {
        // Show the notification as it is without any customization.
        event.complete(event.notification);
      },
    );
  }

  /// The notification opened handler is called whenever
  /// the user opens a OneSignal push notification
  void Function(OpenedNotificationHandler handler)
      get notificationOpenedHandler =>
          OneSignal.shared.setNotificationOpenedHandler;

  /// Retrieves the OneSignal user token ID.
  ///
  /// The user token ID is a unique identifier assigned by OneSignal to each user/device.
  /// It can be used to target specific users when sending notifications.
  ///
  /// Example usage:
  /// ```dart
  /// String? tokenId = await OneSignalRepository().getUserTokenId();
  /// ```
  Future<String?> getUserTokenId() async {
    final deviceState = await OneSignal.shared.getDeviceState();
    final tokenId = deviceState?.userId;
    return tokenId;
  }

  /// Sends a simple notification to one or more users identified by their tokens.
  ///
  /// Parameters:
  /// - `tokenIds`: List of user token IDs to which the notification will be sent.
  /// - `title`: The title of the notification.
  /// - `description`: The body/content of the notification.
  ///
  /// Example usage:
  /// ```dart
  /// await OneSignalRepository().sendNotificationToUsers(
  ///   tokenIds: ['user_token_1', 'user_token_2'],
  ///   title: 'New Message',
  ///   description: 'You have a new message!',
  /// );
  /// ```
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

  /// Sends a notification to one or more users with additional custom data, including a redirection path.
  ///
  /// Parameters:
  /// - `tokenIds`: List of user token IDs to which the notification will be sent.
  /// - `title`: The title of the notification.
  /// - `description`: The body/content of the notification.
  /// - `additionalData`: Additional custom data to be included in the notification, such as the redirection path.
  ///
  /// Example usage:
  /// ```dart
  /// await OneSignalRepository().sendNotificationWithPath(
  ///   tokenIds: ['user_token_1', 'user_token_2'],
  ///   title: 'New Message',
  ///   description: 'You have a new message!',
  ///   additionalData: PushNotificationData(
  ///     redirectionPath: '/messages',
  ///   ),
  /// );
  /// ```
  Future<void> sendNotificationWithPath({
    required List<String> tokenIds,
    required String title,
    required String description,
    required PushNotificationData additionalData,
  }) async {
    final notification = OSCreateNotification(
      playerIds: tokenIds,
      content: description,
      heading: title,
      additionalData: additionalData.toJson(),
    );
    await OneSignal.shared.postNotification(notification);
  }

  /// Sends a notification to one or more users with custom action buttons.
  ///
  /// Parameters:
  /// - `tokenIds`: List of user token IDs to which the notification will be sent.
  /// - `title`: The title of the notification.
  /// - `description`: The body/content of the notification.
  /// - `additionalData`: Additional custom data to be included in the notification.
  ///
  /// Example usage:
  /// ```dart
  /// await OneSignalRepository().sendNotificationWithButtons(
  ///   tokenIds: ['user_token_1', 'user_token_2'],
  ///   title: 'New Message',
  ///   description: 'You have a new message!',
  ///   additionalData: PushNotificationData(
  ///     action: 'open_chat',
  ///   ),
  /// );
  /// ```
  Future<void> sendNotificationWithButtons({
    required List<String> tokenIds,
    required String title,
    required String description,
    PushNotificationData? additionalData,
  }) async {
    // Now you have a valid player ID, and you can use it to send the notification
    var notification = OSCreateNotification(
      playerIds: tokenIds,
      content: title,
      heading: description,
      additionalData: additionalData?.toJson(),
      buttons: [
        /// Maximum of 3 buttons allowed
        OSActionButton(
          text: 'Button 1',
          id: 'button1',
        ),
        OSActionButton(
          text: 'Button 2',
          id: 'button2',
        ),
      ],
    );

    await OneSignal.shared.postNotification(notification);
  }
}
