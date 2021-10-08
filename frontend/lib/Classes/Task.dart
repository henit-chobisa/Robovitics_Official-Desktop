import 'package:frontend/Classes/DiscussionModel.dart';
import 'package:frontend/Classes/SubmissionModel.dart';
import 'package:frontend/Classes/UserB.dart';
import 'package:frontend/Classes/qna.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Task.g.dart';

@JsonSerializable()
class Task {
  Task(
      {required this.title,
      required this.description,
      required this.assignedDate,
      required this.lastDate,
      required this.referencingDocumentLink,
      required this.bannerLink,
      required this.mentor,
      required this.core,
      required this.isCompleted,
      required this.isTeamTask,
      required this.discussions,
      required this.qna,
      required this.submissions,
      required this.pointsAlloted,
      required this.assignedTo,
      required this.acknowledgedBy});

  factory Task.fromJson(Map<String, dynamic> data) => _$TaskFromJson(data);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  final String title;
  final String description;
  final DateTime assignedDate;
  final DateTime lastDate;
  final String referencingDocumentLink;
  final String bannerLink;
  final UserB mentor;
  List<UserB> acknowledgedBy;
  List<UserB> assignedTo;
  final String core;
  final bool isCompleted;
  final bool isTeamTask;
  final List<DiscussionModel> discussions;
  final List<QnaModel> qna;
  final List<Submission> submissions;
  final int pointsAlloted;
}
