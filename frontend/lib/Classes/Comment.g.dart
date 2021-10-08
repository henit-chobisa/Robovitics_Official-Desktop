// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    comment: json['comment'] as String,
    commentedBy: UserB.fromJson(json['commentedBy'] as Map<String, dynamic>),
    timeStamp: DateTime.parse(json['timeStamp'] as String),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment': instance.comment,
      'timeStamp': instance.timeStamp.toIso8601String(),
      'commentedBy': instance.commentedBy,
    };
