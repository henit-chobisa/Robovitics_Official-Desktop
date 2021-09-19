import 'package:frontend/Classes/Event.dart';
import 'package:frontend/Classes/registrationModel.dart';

class ContributionModel {
  ContributionModel(
      this.eventID, this.contributorID, this.points, this.registrationDetails);

  final Event eventID;
  final String contributorID;
  final int points;
  final List<registrationModel> registrationDetails;
}
