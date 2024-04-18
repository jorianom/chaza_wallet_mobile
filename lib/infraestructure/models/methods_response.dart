// To parse this JSON data, do
//
//     final responseMethods = responseMethodsFromJson(jsonString);

import 'dart:convert';

ResponseMethods responseMethodsFromJson(String str) =>
    ResponseMethods.fromJson(json.decode(str));

String responseMethodsToJson(ResponseMethods data) =>
    json.encode(data.toJson());

class ResponseMethods {
  final Data? data;

  ResponseMethods({
    this.data,
  });

  factory ResponseMethods.fromJson(Map<String, dynamic> json) =>
      ResponseMethods(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final PostMethod? postMethod;

  Data({
    this.postMethod,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postMethod: json["postMethod"] == null
            ? null
            : PostMethod.fromJson(json["postMethod"]),
      );

  Map<String, dynamic> toJson() => {
        "postMethod": postMethod?.toJson(),
      };
}

class PostMethod {
  final bool? ok;
  final Response? response;

  PostMethod({
    this.ok,
    this.response,
  });

  factory PostMethod.fromJson(Map<String, dynamic> json) => PostMethod(
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
  final String? id;
  final int? status;

  Response({
    this.id,
    this.status,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}
