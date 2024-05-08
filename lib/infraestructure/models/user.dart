// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final Data? data;

  User({
    this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final GetUser? getUser;

  Data({
    this.getUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        getUser:
            json["getUser"] == null ? null : GetUser.fromJson(json["getUser"]),
      );

  Map<String, dynamic> toJson() => {
        "getUser": getUser?.toJson(),
      };
}

class GetUser {
  final String? id;
  final String? firstName;
  final String? documentType;
  final String? phone;
  final DateTime? dateBirth;
  final String? documentNumber;
  final String? lastName;

  GetUser({
    this.id,
    this.firstName,
    this.documentType,
    this.phone,
    this.dateBirth,
    this.documentNumber,
    this.lastName,
  });

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
        id: json["id"],
        firstName: json["firstName"],
        documentType: json["documentType"],
        phone: json["phone"],
        dateBirth: json["dateBirth"] == null
            ? null
            : DateTime.parse(json["dateBirth"]),
        documentNumber: json["documentNumber"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "documentType": documentType,
        "phone": phone,
        "dateBirth":
            "${dateBirth!.year.toString().padLeft(4, '0')}-${dateBirth!.month.toString().padLeft(2, '0')}-${dateBirth!.day.toString().padLeft(2, '0')}",
        "documentNumber": documentNumber,
        "lastName": lastName,
      };
}
