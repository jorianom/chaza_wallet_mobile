// To parse this JSON data, do
//
//     final errorsAuth = errorsAuthFromJson(jsonString);

import 'dart:convert';

ErrorsAuth errorsAuthFromJson(String str) =>
    ErrorsAuth.fromJson(json.decode(str));

String errorsAuthToJson(ErrorsAuth data) => json.encode(data.toJson());

class ErrorsAuth {
  final List<Error>? errors;
  final Data? data;

  ErrorsAuth({
    this.errors,
    this.data,
  });

  factory ErrorsAuth.fromJson(Map<String, dynamic> json) => ErrorsAuth(
        errors: json["errors"] == null
            ? []
            : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors == null
            ? []
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
        "data": data?.toJson(),
      };
}

class Data {
  final dynamic authenticateUserAuth;

  Data({
    this.authenticateUserAuth,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        authenticateUserAuth: json["authenticateUserAuth"],
      );

  Map<String, dynamic> toJson() => {
        "authenticateUserAuth": authenticateUserAuth,
      };
}

class Error {
  final String? message;
  final List<Location>? locations;
  final List<String>? path;

  Error({
    this.message,
    this.locations,
    this.path,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"]!.map((x) => Location.fromJson(x))),
        path: json["path"] == null
            ? []
            : List<String>.from(json["path"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
        "path": path == null ? [] : List<dynamic>.from(path!.map((x) => x)),
      };
}

class Location {
  final int? line;
  final int? column;

  Location({
    this.line,
    this.column,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        line: json["line"],
        column: json["column"],
      );

  Map<String, dynamic> toJson() => {
        "line": line,
        "column": column,
      };
}
