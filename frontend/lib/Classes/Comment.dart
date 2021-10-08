import 'package:frontend/Classes/UserB.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Comment.g.dart';

@JsonSerializable()
class Comment {
  Comment(
      {required this.comment,
      required this.commentedBy,
      required this.timeStamp});

  factory Comment.fromJson(Map<String, dynamic> data) =>
      _$CommentFromJson(data);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  final String comment;
  final DateTime timeStamp;
  final UserB commentedBy;
}
