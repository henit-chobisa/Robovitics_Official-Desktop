// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserB.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserB _$UserBFromJson(Map<String, dynamic> json) {
  return UserB(
    id: json['_id'] as String,
    userID: json['userID'] as String,
    userName: json['userName'] as String,
    email: json['email'] as String,
    photoURL: json['photoURL'] as String,
    core: json['core'] as String,
  );
}

Map<String, dynamic> _$UserBToJson(UserB instance) => <String, dynamic>{
      '_id': instance.id,
      'userID': instance.userID,
      'userName': instance.userName,
      'photoURL': instance.photoURL,
      'email': instance.email,
      'core': instance.core,
    };
