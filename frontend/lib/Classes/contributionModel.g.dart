// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contributionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContributionModel _$ContributionModelFromJson(Map<String, dynamic> json) {
  return ContributionModel(
    json['eventID'] as String,
    json['contributorID'] as String,
    json['points'] as int,
    json['registrationDetails'] as String,
    json['eventName'] as String,
    json['eventDescription'] as String,
    json['eventLogo'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$ContributionModelToJson(ContributionModel instance) =>
    <String, dynamic>{
      'eventName': instance.eventName,
      'eventDescription': instance.eventDescription,
      'eventLogo': instance.eventLogo,
      'type': instance.type,
      'eventID': instance.eventID,
      'contributorID': instance.contributorID,
      'points': instance.points,
      'registrationDetails': instance.registrationDetails,
    };
