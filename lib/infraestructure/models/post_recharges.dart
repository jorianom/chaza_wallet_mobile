// To parse this JSON data, do
//
//     final postRecharge = postRechargeFromJson(jsonString);

import 'dart:convert';

PostRecharge postRechargeFromJson(String str) =>
    PostRecharge.fromJson(json.decode(str));

String postRechargeToJson(PostRecharge data) => json.encode(data.toJson());

class PostRecharge {
  final Data? data;

  PostRecharge({
    this.data,
  });

  factory PostRecharge.fromJson(Map<String, dynamic> json) => PostRecharge(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final PostRechargeClass? postRecharge;

  Data({
    this.postRecharge,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postRecharge: json["postRecharge"] == null
            ? null
            : PostRechargeClass.fromJson(json["postRecharge"]),
      );

  Map<String, dynamic> toJson() => {
        "postRecharge": postRecharge?.toJson(),
      };
}

class PostRechargeClass {
  final bool? ok;
  final Response? response;

  PostRechargeClass({
    this.ok,
    this.response,
  });

  factory PostRechargeClass.fromJson(Map<String, dynamic> json) =>
      PostRechargeClass(
        ok: json["ok"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "response": response?.toJson(),
      };
}

class Response {
  final String? message;

  Response({
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
