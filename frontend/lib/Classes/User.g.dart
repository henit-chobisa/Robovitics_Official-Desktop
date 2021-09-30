// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['_id'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    photoURL: json['photoURL'] as String,
    department: json['department'] as String,
    phoneNumber: json['phoneNumber'] as String,
    designation: json['designation'] as String,
    yearOfJoining: json['yearOfJoining'] as String,
    core: json['core'] as String,
    points: json['points'] as int,
    contributions: (json['contributions'] as List<dynamic>)
        .map((e) => ContributionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'photoURL': instance.photoURL,
      'department': instance.department,
      'phoneNumber': instance.phoneNumber,
      'designation': instance.designation,
      'core': instance.core,
      'points': instance.points,
      'contributions': instance.contributions,
      'yearOfJoining': instance.yearOfJoining,
    };
