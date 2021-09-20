import 'package:frontend/Classes/Event.dart';
import 'package:frontend/Classes/registrationModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contributionModel.g.dart';

@JsonSerializable()
class ContributionModel {
  ContributionModel(
      this.eventID,
      this.contributorID,
      this.points,
      this.registrationDetails,
      this.eventName,
      this.eventDescription,
      this.eventLogo,
      this.type);

  factory ContributionModel.fromJson(Map<String, dynamic> data) =>
      _$ContributionModelFromJson(data);
  Map<String, dynamic> toJson() => _$ContributionModelToJson(this);

  final String eventName;
  final String eventDescription;
  final String eventLogo;
  final String type;
  final String eventID;
  final String contributorID;
  final int points;
  final String registrationDetails;
}
