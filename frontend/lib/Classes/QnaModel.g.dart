// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QnaModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QnaModel _$QnaModelFromJson(Map<String, dynamic> json) {
  return QnaModel(
    id: json['_id'] as String,
    TaskID: json['TaskID'] as String,
    question: json['question'] as String,
    comments: (json['comments'] as List<dynamic>)
        .map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList(),
    raisedBy: UserB.fromJson(json['raisedBy'] as Map<String, dynamic>),
    timeStamp: DateTime.parse(json['timeStamp'] as String),
  );
}

Map<String, dynamic> _$QnaModelToJson(QnaModel instance) => <String, dynamic>{
      'id': instance.id,
      'TaskID': instance.TaskID,
      'question': instance.question,
      'comments': instance.comments,
      'raisedBy': instance.raisedBy,
      'timeStamp': instance.timeStamp.toIso8601String(),
    };
