// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DiscussionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussionModel _$DiscussionModelFromJson(Map<String, dynamic> json) {
  return DiscussionModel(
    id: json['id'] as String,
    userInfo: UserB.fromJson(json['userInfo'] as Map<String, dynamic>),
    payload: json['payload'] as String,
    messageType: json['messageType'] as String,
    timeStamp: DateTime.parse(json['timeStamp'] as String),
  );
}

Map<String, dynamic> _$DiscussionModelToJson(DiscussionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userInfo': instance.userInfo,
      'payload': instance.payload,
      'messageType': instance.messageType,
      'timeStamp': instance.timeStamp.toIso8601String(),
    };
