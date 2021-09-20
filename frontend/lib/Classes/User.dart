import 'package:frontend/Classes/contributionModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.photoURL,
      required this.department,
      required this.phoneNumber,
      required this.designation,
      required this.yearOfJoining,
      required this.core,
      required this.points,
      required this.contributions});

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String photoURL;
  final String department;
  final String phoneNumber;
  final String designation;
  final String core;
  final int points;
  final List<ContributionModel> contributions;
  final String yearOfJoining;

  static void getUserName(String userID) {
    print('return userID of the user');
  }

  static void getUserImage(String userID) {
    print('return image');
  }
}
