// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instaPostModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

instapostModel _$instapostModelFromJson(Map<String, dynamic> json) {
  return instapostModel(
    json['shortCode'] as String,
    json['likesCount'] as int,
    json['photoURL'] as String,
  );
}

Map<String, dynamic> _$instapostModelToJson(instapostModel instance) =>
    <String, dynamic>{
      'shortCode': instance.shortCode,
      'likesCount': instance.likesCount,
      'photoURL': instance.photoURL,
    };
