import 'package:frontend/Classes/UserB.dart';
import 'package:json_annotation/json_annotation.dart';
part 'DiscussionModel.g.dart';

@JsonSerializable()
class DiscussionModel {
  DiscussionModel(
      {required this.id,
      required this.userInfo,
      required this.payload,
      required this.messageType,
      required this.timeStamp});

  factory DiscussionModel.fromJson(Map<String, dynamic> data) =>
      _$DiscussionModelFromJson(data);
  Map<String, dynamic> toJson() => _$DiscussionModelToJson(this);

  final String id;
  final UserB userInfo;
  final String payload;
  final String messageType;
  final DateTime timeStamp;
}
