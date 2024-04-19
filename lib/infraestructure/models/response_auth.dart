// To parse this JSON data, do
//
//     final authenticateUserAuth = authenticateUserAuthFromJson(jsonString);

import 'dart:convert';

AuthenticateUserAuth authenticateUserAuthFromJson(String str) =>
    AuthenticateUserAuth.fromJson(json.decode(str));

String authenticateUserAuthToJson(AuthenticateUserAuth data) =>
    json.encode(data.toJson());

class AuthenticateUserAuth {
  final Data? data;

  AuthenticateUserAuth({
    this.data,
  });

  factory AuthenticateUserAuth.fromJson(Map<String, dynamic> json) =>
      AuthenticateUserAuth(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final AuthenticateUserAuthClass? authenticateUserAuth;

  Data({
    this.authenticateUserAuth,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        authenticateUserAuth: json["authenticateUserAuth"] == null
            ? null
            : AuthenticateUserAuthClass.fromJson(json["authenticateUserAuth"]),
      );

  Map<String, dynamic> toJson() => {
        "authenticateUserAuth": authenticateUserAuth?.toJson(),
      };
}

class AuthenticateUserAuthClass {
  final bool? ok;
  final String? token;

  AuthenticateUserAuthClass({
    this.ok,
    this.token,
  });

  factory AuthenticateUserAuthClass.fromJson(Map<String, dynamic> json) =>
      AuthenticateUserAuthClass(
        ok: json["ok"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "token": token,
      };
}
