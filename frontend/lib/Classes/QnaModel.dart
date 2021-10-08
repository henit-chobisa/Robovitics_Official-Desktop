import 'package:frontend/Classes/Comment.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:json_annotation/json_annotation.dart';
part 'QnaModel.g.dart';

@JsonSerializable()
class QnaModel {
  QnaModel(
      {required this.id,
      required this.TaskID,
      required this.question,
      required this.comments,
      required this.raisedBy,
      required this.timeStamp});

  factory QnaModel.FromJson(Map<String, dynamic> data) =>
      _$QnaModelFromJson(data);
  Map<String, dynamic> toJson() => _$QnaModelToJson(this);

  String id;
  String TaskID;
  String question;
  List<Comment> comments;
  UserB raisedBy;
  DateTime timeStamp;
}
