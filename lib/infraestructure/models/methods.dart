// To parse this JSON data, do
//
//     final methods = methodsFromJson(jsonString);

import 'dart:convert';

Methods methodsFromJson(String str) => Methods.fromJson(json.decode(str));

String methodsToJson(Methods data) => json.encode(data.toJson());

class Methods {
  final String? message;
  final int? status;
  final List<Datum>? data;

  Methods({
    this.message,
    this.status,
    this.data,
  });

  factory Methods.fromJson(Map<String, dynamic> json) => Methods(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final String? id;
  final String? user;
  final String? name;
  final String? titular;
  final DateTime? duedate;
  final String? number;
  final String? type;
  final String? sucursal;

  Datum({
    this.id,
    this.user,
    this.name,
    this.titular,
    this.duedate,
    this.number,
    this.type,
    this.sucursal,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        titular: json["titular"],
        duedate:
            json["duedate"] == null ? null : DateTime.parse(json["duedate"]),
        number: json["number"],
        type: json["type"],
        sucursal: json["sucursal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "titular": titular,
        "duedate":
            "${duedate!.year.toString().padLeft(4, '0')}-${duedate!.month.toString().padLeft(2, '0')}-${duedate!.day.toString().padLeft(2, '0')}",
        "number": number,
        "type": type,
        "sucursal": sucursal,
      };
}
