// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

registrationModel _$registrationModelFromJson(Map<String, dynamic> json) {
  return registrationModel(
    json['EventID'] as String,
    json['attendeeName'] as String,
    User.fromJson(json['contributor'] as Map<String, dynamic>),
    json['Platform'] as String,
  );
}

Map<String, dynamic> _$registrationModelToJson(registrationModel instance) =>
    <String, dynamic>{
      'EventID': instance.EventID,
      'attendeeName': instance.attendeeName,
      'contributor': instance.contributor,
      'Platform': instance.Platform,
    };
