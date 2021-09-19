import 'package:frontend/Classes/User.dart';
import 'package:frontend/Classes/instaPostModel.dart';
import 'package:frontend/Classes/registrationModel.dart';

class Event {
  Event(
      this.eventTitle,
      this.eventDescription,
      this.eventTime,
      this.eventLogo,
      this.eventImages,
      this.platformLink,
      this.instagramReach,
      this.instagramTarget,
      this.instagramPosts,
      this.facebookReach,
      this.facebookTarget,
      this.linkedInReach,
      this.linkedInTarget,
      this.registrationPoints,
      this.registrationTarget,
      this.totalRegistrations,
      this.topContributor,
      this.registrations,
      this.contributors);

  //Event Details
  final String eventTitle;
  final String eventDescription;
  final DateTime eventTime;
  final String eventLogo;
  final List<String> eventImages;
  final String platformLink;

  //  Social Media
  final int instagramReach;
  final int instagramTarget;
  final List<instapostModel> instagramPosts;

  final int facebookReach;
  final int facebookTarget;

  final int linkedInReach;
  final int linkedInTarget;

  final int registrationPoints;
  final int registrationTarget;
  final int totalRegistrations;

  final User topContributor;
  final List<registrationModel> registrations;
  final List<User> contributors;
}
