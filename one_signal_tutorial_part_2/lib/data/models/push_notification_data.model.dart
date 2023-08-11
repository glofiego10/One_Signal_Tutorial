import 'package:json_annotation/json_annotation.dart';

import 'push_notification_data_args_type.enum.dart';

part 'push_notification_data.model.g.dart';

/// This class represents data for a push notification.
@JsonSerializable()
class PushNotificationData {
  /// The path associated with the push notification. It is optional and can be `null`.
  String? path;

  /// An enumeration indicating the type of arguments expected in the push notification.
  PushNotificationDataArgsType? argsType;

  /// Indicates whether the push notification should redirect to a specific screen.
  final bool redirect;

  /// A map containing additional arguments to be sent with the push notification.
  final Map<String, dynamic>? args;

  /// Constructs a new instance of [PushNotificationData].
  PushNotificationData(
    this.args, {
    required this.redirect,
    this.path,
    this.argsType,
  });

  factory PushNotificationData.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationDataToJson(this);
}
