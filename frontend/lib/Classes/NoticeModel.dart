import 'package:frontend/Classes/DiscussionModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moment/moment.dart';
import 'UserB.dart';
part 'NoticeModel.g.dart';

@JsonSerializable()
class NoticeModel {
  NoticeModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.docLink,
      required this.timeStamp,
      required this.AcknowledgeBy,
      required this.Discussions});

  factory NoticeModel.fromJson(Map<String, dynamic> data) =>
      _$NoticeModelFromJson(data);
  Map<String, dynamic> toJson() => _$NoticeModelToJson(this);

  final String id;
  final String title;
  final String description;
  final String docLink;
  final DateTime timeStamp;
  final List<UserB> AcknowledgeBy;
  final List<DiscussionModel> Discussions;
}
