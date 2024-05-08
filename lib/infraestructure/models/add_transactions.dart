// To parse this JSON data, do
//
//     final addTransaction = addTransactionFromJson(jsonString);

import 'dart:convert';

AddTransaction addTransactionFromJson(String str) =>
    AddTransaction.fromJson(json.decode(str));

String addTransactionToJson(AddTransaction data) => json.encode(data.toJson());

class AddTransaction {
  final Data? data;

  AddTransaction({
    this.data,
  });

  factory AddTransaction.fromJson(Map<String, dynamic> json) => AddTransaction(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final AddTransactionClass? addTransaction;

  Data({
    this.addTransaction,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        addTransaction: json["addTransaction"] == null
            ? null
            : AddTransactionClass.fromJson(json["addTransaction"]),
      );

  Map<String, dynamic> toJson() => {
        "addTransaction": addTransaction?.toJson(),
      };
}

class AddTransactionClass {
  final int? transactionId;

  AddTransactionClass({
    this.transactionId,
  });

  factory AddTransactionClass.fromJson(Map<String, dynamic> json) =>
      AddTransactionClass(
        transactionId: json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
      };
}
