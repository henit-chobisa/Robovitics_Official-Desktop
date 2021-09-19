// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contributionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContributionModel _$ContributionModelFromJson(Map<String, dynamic> json) {
  return ContributionModel(
    Event.fromJson(json['eventID'] as Map<String, dynamic>),
    json['contributorID'] as String,
    json['points'] as int,
    (json['registrationDetails'] as List<dynamic>)
        .map((e) => registrationModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ContributionModelToJson(ContributionModel instance) =>
    <String, dynamic>{
      'eventID': instance.eventID,
      'contributorID': instance.contributorID,
      'points': instance.points,
      'registrationDetails': instance.registrationDetails,
    };
