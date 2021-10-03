import 'package:json_annotation/json_annotation.dart';
part 'ConcentModel.g.dart';

@JsonSerializable()
class ConcentModel {
  ConcentModel(
      {required this.id,
      required this.Concent,
      required this.Upvotes,
      required this.Downvotes});

  factory ConcentModel.fromJson(Map<String, dynamic> data) =>
      _$ConcentModelFromJson(data);
  Map<String, dynamic> toJson() => _$ConcentModelToJson(this);

  String Concent;
  String id;
  int Upvotes;
  int Downvotes;
}
