import 'package:json_annotation/json_annotation.dart';

import 'UserB.dart';
part 'SubmissionModel.g.dart';

@JsonSerializable()
class Submission {
  Submission(
      {required this.id,
      required this.SubmittedBy,
      required this.Comment,
      required this.TaskID,
      required this.docLink,
      required this.isVerified,
      required this.SubmittedOn});

  factory Submission.fromJson(Map<String, dynamic> data) =>
      _$SubmissionFromJson(data);
  Map<String, dynamic> toJson() => _$SubmissionToJson(this);

  final String id;
  final String TaskID;
  final UserB SubmittedBy;
  final String Comment;
  final String docLink;
  final DateTime SubmittedOn;
  final bool isVerified;
}
