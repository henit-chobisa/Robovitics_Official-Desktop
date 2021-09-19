import 'package:json_annotation/json_annotation.dart';
part 'instaPostModel.g.dart';

@JsonSerializable()
class instapostModel {
  instapostModel(this.shortCode, this.likesCount, this.photoURL);

  factory instapostModel.FromJson(Map<String, dynamic> data) =>
      _$instapostModelFromJson(data);
  Map<String, dynamic> toJson() => _$instapostModelToJson(this);

  final String shortCode;
  final int likesCount;
  final String photoURL;
}
