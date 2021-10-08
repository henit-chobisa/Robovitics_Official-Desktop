import 'package:frontend/Classes/Comment.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:json_annotation/json_annotation.dart';
part 'qna.g.dart';

@JsonSerializable()
class QnaModel {
  QnaModel(
      {required this.question,
      required this.TaskID,
      required this.comments,
      required this.raisedBy,
      required this.timeStamp});

  factory QnaModel.fromJson(Map<String, dynamic> data) =>
      _$QnaModelFromJson(data);
  Map<String, dynamic> toJson() => _$QnaModelToJson(this);

  final String TaskID;
  final String question;
  final List<Comment> comments;
  final UserB raisedBy;
  final DateTime timeStamp;
}
