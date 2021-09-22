// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

registrationModel _$registrationModelFromJson(Map<String, dynamic> json) {
  return registrationModel(
    json['EventID'] as String,
    json['attendeeName'] as String,
    json['contributor'] as String,
    json['platform'] as String,
    json['contributorName'] as String,
    json['contributorImage'] as String,
    json['contributorCore'] as String,
    json['contributorYOJ'] as String,
  );
}

Map<String, dynamic> _$registrationModelToJson(registrationModel instance) =>
    <String, dynamic>{
      'contributorName': instance.contributorName,
      'contributorImage': instance.contributorImage,
      'contributorCore': instance.contributorCore,
      'contributorYOJ': instance.contributorYOJ,
      'EventID': instance.EventID,
      'attendeeName': instance.attendeeName,
      'contributor': instance.contributor,
      'platform': instance.platform,
    };
