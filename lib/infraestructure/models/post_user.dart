// To parse this JSON data, do
//
//     final postUsers = postUsersFromJson(jsonString);

import 'dart:convert';

PostUsers postUsersFromJson(String str) => PostUsers.fromJson(json.decode(str));

String postUsersToJson(PostUsers data) => json.encode(data.toJson());

class PostUsers {
  final Data? data;

  PostUsers({
    this.data,
  });

  factory PostUsers.fromJson(Map<String, dynamic> json) => PostUsers(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final PostUsersClass? postUsers;

  Data({
    this.postUsers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postUsers: json["postUsers"] == null
            ? null
            : PostUsersClass.fromJson(json["postUsers"]),
      );

  Map<String, dynamic> toJson() => {
        "postUsers": postUsers?.toJson(),
      };
}

class PostUsersClass {
  final bool? ok;
  final User? user;

  PostUsersClass({
    this.ok,
    this.user,
  });

  factory PostUsersClass.fromJson(Map<String, dynamic> json) => PostUsersClass(
        ok: json["ok"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user?.toJson(),
      };
}

class User {
  final String? id;
  final String? firstName;

  User({
    this.id,
    this.firstName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
      };
}
