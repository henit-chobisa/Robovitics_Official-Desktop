import 'package:frontend/Classes/User.dart';
import 'package:json_annotation/json_annotation.dart';
part 'registrationModel.g.dart';

@JsonSerializable()
class registrationModel {
  registrationModel(
      this.EventID, this.attendeeName, this.contributor, this.Platform);

  factory registrationModel.fromJson(Map<String, dynamic> data) =>
      _$registrationModelFromJson(data);
  Map<String, dynamic> toJson() => _$registrationModelToJson(this);

  final String EventID;
  final String attendeeName;
  final User contributor;
  final String Platform;
}
