import 'package:json_annotation/json_annotation.dart';
part 'ConcentModel.g.dart';

@JsonSerializable()
class ConcentModel {
  ConcentModel(
      {required this.id,
      required this.Concent,
      required this.Upvotes,
      required this.Downvotes,
      required this.DownvotedBy,
      required this.UpvotedBy});

  factory ConcentModel.fromJson(Map<String, dynamic> data) =>
      _$ConcentModelFromJson(data);
  Map<String, dynamic> toJson() => _$ConcentModelToJson(this);

  String Concent;
  List<String> UpvotedBy;
  List<String> DownvotedBy;
  String id;
  int Upvotes;
  int Downvotes;
}
