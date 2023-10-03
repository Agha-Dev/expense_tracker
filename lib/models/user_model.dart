import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.email,
    required this.username,
    required this.uid
  });

  String email;
  String username;
  String uid;
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json["email"],
      username: json["username"],
      uid: json['uid']??"");

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "uid":uid
      };
}
