import 'package:json_placeholder_social_media/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      username: json["username"],
    );
  }
}
