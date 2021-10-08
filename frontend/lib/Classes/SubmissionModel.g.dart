// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubmissionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Submission _$SubmissionFromJson(Map<String, dynamic> json) {
  return Submission(
    id: json['_id'] as String,
    SubmittedBy: UserB.fromJson(json['SubmittedBy'] as Map<String, dynamic>),
    Comment: json['Comment'] as String,
    TaskID: json['TaskID'] as String,
    docLink: json['docLink'] as String,
    isVerified: json['isVerified'] as bool,
    SubmittedOn: DateTime.parse(json['SubmittedOn'] as String),
  );
}

Map<String, dynamic> _$SubmissionToJson(Submission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'TaskID': instance.TaskID,
      'SubmittedBy': instance.SubmittedBy,
      'Comment': instance.Comment,
      'docLink': instance.docLink,
      'SubmittedOn': instance.SubmittedOn.toIso8601String(),
      'isVerified': instance.isVerified,
    };
