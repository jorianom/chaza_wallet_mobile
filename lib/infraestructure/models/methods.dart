// To parse this JSON data, do
//
//     final methods = methodsFromJson(jsonString);

import 'dart:convert';

Methods methodsFromJson(String str) => Methods.fromJson(json.decode(str));

String methodsToJson(Methods data) => json.encode(data.toJson());

class Methods {
  final Data? data;

  Methods({
    this.data,
  });

  factory Methods.fromJson(Map<String, dynamic> json) => Methods(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final List<GetMethod>? getMethods;

  Data({
    this.getMethods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        getMethods: json["getMethods"] == null
            ? []
            : List<GetMethod>.from(
                json["getMethods"]!.map((x) => GetMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getMethods": getMethods == null
            ? []
            : List<dynamic>.from(getMethods!.map((x) => x.toJson())),
      };
}

class GetMethod {
  final String? id;
  final String? user;
  final String? number;
  final String? sucursal;
  final String? type;
  final String? titular;
  final String? name;
  final DateTime? duedate;

  GetMethod({
    this.id,
    this.user,
    this.number,
    this.sucursal,
    this.type,
    this.titular,
    this.name,
    this.duedate,
  });

  factory GetMethod.fromJson(Map<String, dynamic> json) => GetMethod(
        id: json["id"],
        user: json["user"],
        number: json["number"],
        sucursal: json["sucursal"],
        type: json["type"],
        titular: json["titular"],
        name: json["name"],
        duedate:
            json["duedate"] == null ? null : DateTime.parse(json["duedate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "number": number,
        "sucursal": sucursal,
        "type": type,
        "titular": titular,
        "name": name,
        "duedate":
            "${duedate!.year.toString().padLeft(4, '0')}-${duedate!.month.toString().padLeft(2, '0')}-${duedate!.day.toString().padLeft(2, '0')}",
      };
}
