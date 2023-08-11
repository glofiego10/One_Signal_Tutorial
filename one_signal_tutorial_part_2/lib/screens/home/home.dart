import 'package:flutter/material.dart';
import 'package:one_signal_tutorial/app/routes/router.gr.dart';
import 'package:one_signal_tutorial/data/models/models.dart';
import 'package:one_signal_tutorial/domain/one_signal_repository.dart';
import 'package:one_signal_tutorial/widgets/notification_button.dart';

/// The home page of the app where users can send various types of notifications.
class HomePage extends StatefulWidget {
  /// Creates a Home Page widget.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = OneSignalRepository();
  bool isSendingNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'OneSignal Notification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// Button to send a simple notification.
            NotificationButton(
              label: 'Send Notification',
              onPressed: sendNotificationToUsers,
              isSending: isSendingNotification,
            ),

            /// Button to send a notification with redirection to DetailsRoute1.
            NotificationButton(
              label: 'Send Notification with redirection',
              onPressed: () => sendNotificationToUsersWithPath(
                argsType: PushNotificationDataArgsType.detailsPage1,
                path: DetailsRoute1.name,
                args: <String, dynamic>{},
              ),
              isSending: isSendingNotification,
            ),

            /// Button to send a notification with redirection and custom arguments to DetailsRoute2.
            NotificationButton(
              label: 'Send Notification with redirection and arguments',
              onPressed: () => sendNotificationToUsersWithPath(
                argsType: PushNotificationDataArgsType.detailsPage2,
                path: DetailsRoute2.name,
                args: const DetailsRoute2Args(
                  textNotification: 'Testing Notification',
                ).toJson(),
              ),
              isSending: isSendingNotification,
            ),

            /// Button to send a notification with buttons to a specific user (Phone2).
            /// This button sends a notification with action buttons to a particular user identified by their token.
            /// The notification includes buttons that can trigger specific actions when pressed.
            NotificationButton(
              label: 'Send Notification with buttons',
              onPressed: () => sendNotificationToUsersWithButtons(
                  tokenUser: 'a7c4ab55-bd7d-4403-973d-f1848b710de1'),
              isSending: isSendingNotification,
            ),
          ],
        ),
      ),
    );
  }

  /// Sends a notification to the user when the button is pressed.
  void sendNotificationToUsers() async {
    setState(() {
      isSendingNotification = true;
    });

    final token = await repository.getUserTokenId();
    await repository.sendNotificationToUsers(
      tokenIds: [token!],
      title: 'Notification Title Test',
      description: 'Notification sent by the user $token',
    );

    setState(() {
      isSendingNotification = false;
    });
  }

  /// Sends a notification to the user with redirection when the button is pressed.
  void sendNotificationToUsersWithPath({
    required String path,
    required PushNotificationDataArgsType? argsType,
    required Map<String, dynamic> args,
  }) async {
    setState(() {
      isSendingNotification = true;
    });

    final token = await repository.getUserTokenId();
    await repository.sendNotificationWithPath(
      tokenIds: [token!],
      title: 'Notification Title Test',
      description: 'Notification sent by the user $token',
      additionalData: PushNotificationData(
        args,
        redirect: true,
        argsType: argsType,
        path: path,
      ),
    );

    setState(() {
      isSendingNotification = false;
    });
  }

  /// Sends a notification to the user with buttons when the button is pressed.
  void sendNotificationToUsersWithButtons({
    required String tokenUser,
  }) async {
    setState(() {
      isSendingNotification = true;
    });

    final token = await repository.getUserTokenId();
    await repository.sendNotificationWithButtons(
      tokenIds: [tokenUser],
      title: 'Notification Title Test',
      description: 'Notification sent by the user $token',
    );

    setState(() {
      isSendingNotification = false;
    });
  }
}
