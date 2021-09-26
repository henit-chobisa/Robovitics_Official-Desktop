import 'package:json_annotation/json_annotation.dart';
part 'UserB.g.dart';

@JsonSerializable()
class UserB {
  UserB(
      {required this.id,
      required this.userID,
      required this.userName,
      required this.email,
      required this.photoURL,
      required this.core});

  factory UserB.fromJson(Map<String, dynamic> data) => _$UserBFromJson(data);
  Map<String, dynamic> toJson() => _$UserBToJson(this);
  final String id;
  final String userID;
  final String userName;
  final String photoURL;
  final String email;
  final String core;
}
