// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    json['id'] as String,
    json['eventTitle'] as String,
    json['eventDescription'] as String,
    DateTime.parse(json['eventTime'] as String),
    json['eventLogo'] as String,
    (json['eventImages'] as List<dynamic>).map((e) => e as String).toList(),
    json['platformLink'] as String,
    json['instagramReach'] as int,
    json['instagramTarget'] as int,
    (json['instagramPosts'] as List<dynamic>)
        .map((e) => instapostModel.FromJson(e as Map<String, dynamic>))
        .toList(),
    json['facebookReach'] as int,
    json['facebookTarget'] as int,
    json['linkedInReach'] as int,
    json['linkedInTarget'] as int,
    json['registrationPoints'] as int,
    json['registrationTarget'] as int,
    json['totalRegistrations'] as int,
    User.fromJson(json['topContributor'] as Map<String, dynamic>),
    (json['registrations'] as List<dynamic>)
        .map((e) => registrationModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['contributors'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'eventTitle': instance.eventTitle,
      'eventDescription': instance.eventDescription,
      'eventTime': instance.eventTime.toIso8601String(),
      'eventLogo': instance.eventLogo,
      'eventImages': instance.eventImages,
      'platformLink': instance.platformLink,
      'instagramReach': instance.instagramReach,
      'instagramTarget': instance.instagramTarget,
      'instagramPosts': instance.instagramPosts,
      'facebookReach': instance.facebookReach,
      'facebookTarget': instance.facebookTarget,
      'linkedInReach': instance.linkedInReach,
      'linkedInTarget': instance.linkedInTarget,
      'registrationPoints': instance.registrationPoints,
      'registrationTarget': instance.registrationTarget,
      'totalRegistrations': instance.totalRegistrations,
      'topContributor': instance.topContributor,
      'registrations': instance.registrations,
      'contributors': instance.contributors,
    };
