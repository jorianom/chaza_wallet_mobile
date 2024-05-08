// To parse this JSON data, do
//
//     final balance = balanceFromJson(jsonString);

import 'dart:convert';

Balance balanceFromJson(String str) => Balance.fromJson(json.decode(str));

String balanceToJson(Balance data) => json.encode(data.toJson());

class Balance {
  final Data? data;

  Balance({
    this.data,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final double? calculateBalanceForUser;

  Data({
    this.calculateBalanceForUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        calculateBalanceForUser: json["calculateBalanceForUser"],
      );

  Map<String, dynamic> toJson() => {
        "calculateBalanceForUser": calculateBalanceForUser,
      };
}
