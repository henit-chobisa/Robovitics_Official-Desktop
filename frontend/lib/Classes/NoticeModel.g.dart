// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoticeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) {
  return NoticeModel(
    id: json['_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    docLink: json['docLink'] as String,
    timeStamp: DateTime.parse(json['timeStamp'] as String),
    AcknowledgeBy: (json['AcknowledgeBy'] as List<dynamic>)
        .map((e) => UserB.fromJson(e as Map<String, dynamic>))
        .toList(),
    Discussions: (json['Discussions'] as List<dynamic>)
        .map((e) => DiscussionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NoticeModelToJson(NoticeModel instance) =>
    <String, dynamic>{
      '-id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'docLink': instance.docLink,
      'timeStamp': instance.timeStamp.toIso8601String(),
      'AcknowledgeBy': instance.AcknowledgeBy,
      'Discussions': instance.Discussions,
    };
