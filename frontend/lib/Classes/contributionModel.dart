import 'package:frontend/Classes/Event.dart';
import 'package:frontend/Classes/registrationModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contributionModel.g.dart';

@JsonSerializable()
class ContributionModel {
  ContributionModel(
      this.eventID, this.contributorID, this.points, this.registrationDetails);

  factory ContributionModel.fromJson(Map<String, dynamic> data) =>
      _$ContributionModelFromJson(data);
  Map<String, dynamic> toJson() => _$ContributionModelToJson(this);

  final Event eventID;
  final String contributorID;
  final int points;
  final List<registrationModel> registrationDetails;
}
