import 'package:flutter/material.dart';

/// A custom widget for displaying a notification button with a loading indicator.
class NotificationButton extends StatelessWidget {
  /// The [label] is the text displayed on the button.
  /// The [onPressed] callback is called when the button is pressed.
  /// The [isSending] flag determines if the button is in a "sending" state,
  /// showing a loading indicator and disabling the button if true.
  const NotificationButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.isSending,
  }) : super(key: key);

  final String label;

  final VoidCallback onPressed;

  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSending ? null : onPressed,
      child: isSending
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(label),
    );
  }
}
