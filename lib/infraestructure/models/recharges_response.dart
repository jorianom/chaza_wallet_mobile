// To parse this JSON data, do
//
//     final responseRecharges = responseRechargesFromJson(jsonString);

import 'dart:convert';

ResponseRecharges responseRechargesFromJson(String str) =>
    ResponseRecharges.fromJson(json.decode(str));

String responseRechargesToJson(ResponseRecharges data) =>
    json.encode(data.toJson());

class ResponseRecharges {
  final Data? data;

  ResponseRecharges({
    this.data,
  });

  factory ResponseRecharges.fromJson(Map<String, dynamic> json) =>
      ResponseRecharges(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final List<GetRecharge>? getRecharges;

  Data({
    this.getRecharges,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        getRecharges: json["getRecharges"] == null
            ? []
            : List<GetRecharge>.from(
                json["getRecharges"]!.map((x) => GetRecharge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getRecharges": getRecharges == null
            ? []
            : List<dynamic>.from(getRecharges!.map((x) => x.toJson())),
      };
}

class GetRecharge {
  final String? id;
  final String? user;
  final String? amount;
  final String? date;

  GetRecharge({
    this.id,
    this.user,
    this.amount,
    this.date,
  });

  factory GetRecharge.fromJson(Map<String, dynamic> json) => GetRecharge(
        id: json["id"],
        user: json["user"],
        amount: json["amount"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "amount": amount,
        "date": date,
      };
}
