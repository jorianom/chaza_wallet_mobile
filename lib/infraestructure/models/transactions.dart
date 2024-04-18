// To parse this JSON data, do
//
//     final getTransactions = getTransactionsFromJson(jsonString);

import 'dart:convert';

GetTransactions getTransactionsFromJson(String str) =>
    GetTransactions.fromJson(json.decode(str));

String getTransactionsToJson(GetTransactions data) =>
    json.encode(data.toJson());

class GetTransactions {
  final Data? data;

  GetTransactions({
    this.data,
  });

  factory GetTransactions.fromJson(Map<String, dynamic> json) =>
      GetTransactions(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final List<GetTransactionsForUser>? getTransactionsForUser;

  Data({
    this.getTransactionsForUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        getTransactionsForUser: json["getTransactionsForUser"] == null
            ? []
            : List<GetTransactionsForUser>.from(json["getTransactionsForUser"]!
                .map((x) => GetTransactionsForUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getTransactionsForUser": getTransactionsForUser == null
            ? []
            : List<dynamic>.from(
                getTransactionsForUser!.map((x) => x.toJson())),
      };
}

class GetTransactionsForUser {
  final int? transactionId;
  final double? amount;
  final DateTime? dateTime;
  final String? description;
  final int? senderId;
  final int? receiverId;

  GetTransactionsForUser({
    this.transactionId,
    this.amount,
    this.dateTime,
    this.description,
    this.senderId,
    this.receiverId,
  });

  factory GetTransactionsForUser.fromJson(Map<String, dynamic> json) =>
      GetTransactionsForUser(
        transactionId: json["transactionId"],
        amount: json["amount"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        description: json["description"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "amount": amount,
        "dateTime": dateTime?.toIso8601String(),
        "description": description,
        "senderId": senderId,
        "receiverId": receiverId,
      };
}
