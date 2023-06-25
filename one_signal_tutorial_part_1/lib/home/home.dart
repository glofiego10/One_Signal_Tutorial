import 'package:flutter/material.dart';
import 'package:one_signal_tutorial/one_signal_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
            ElevatedButton(
              onPressed: isSendingNotification ? null : sendNotificationToUsers,
              child: isSendingNotification
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Send Notification'),
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

    // Get the user's token ID
    final token = await repository.getUserTokenId();

    // Send a notification to the user
    await repository.sendNotificationToUsers(
      tokenIds: [token!],
      title: 'Notification Title Test',
      description: 'Notification sent by the user $token',
    );

    setState(() {
      isSendingNotification = false;
    });
  }
}
