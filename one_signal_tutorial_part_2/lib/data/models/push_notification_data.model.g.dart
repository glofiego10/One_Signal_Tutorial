// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_data.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationData _$PushNotificationDataFromJson(
        Map<String, dynamic> json) =>
    PushNotificationData(
      json['args'] != null
          ? Map<String, dynamic>.from(json['args'] as Map)
          : null,
      redirect: json['redirect'] as bool,
      path: json['path'] as String?,
      argsType: $enumDecodeNullable(
          _$PushNotificationDataArgsTypeEnumMap, json['argsType']),
    );

Map<String, dynamic> _$PushNotificationDataToJson(
        PushNotificationData instance) =>
    <String, dynamic>{
      'path': instance.path,
      'argsType': _$PushNotificationDataArgsTypeEnumMap[instance.argsType],
      'redirect': instance.redirect,
      'args': instance.args,
    };

const _$PushNotificationDataArgsTypeEnumMap = {
  PushNotificationDataArgsType.detailsPage1: '0',
  PushNotificationDataArgsType.detailsPage2: '1',
};
