// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final Data? data;

  Product({
    this.data,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final PostProduct? postProduct;

  Data({
    this.postProduct,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postProduct: json["postProduct"] == null
            ? null
            : PostProduct.fromJson(json["postProduct"]),
      );

  Map<String, dynamic> toJson() => {
        "postProduct": postProduct?.toJson(),
      };
}

class PostProduct {
  final bool? ok;
  final ProductClass? product;

  PostProduct({
    this.ok,
    this.product,
  });

  factory PostProduct.fromJson(Map<String, dynamic> json) => PostProduct(
        ok: json["ok"],
        product: json["product"] == null
            ? null
            : ProductClass.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "product": product?.toJson(),
      };
}

class ProductClass {
  final String? id;
  final String? userId;
  final String? kind;
  final String? ea;
  final String? amount;
  final String? installments;
  final DateTime? dateTime;

  ProductClass({
    this.id,
    this.userId,
    this.kind,
    this.ea,
    this.amount,
    this.installments,
    this.dateTime,
  });

  factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
        id: json["id"],
        userId: json["userID"],
        kind: json["kind"],
        ea: json["ea"],
        amount: json["amount"],
        installments: json["installments"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "kind": kind,
        "ea": ea,
        "amount": amount,
        "installments": installments,
        "dateTime": dateTime?.toIso8601String(),
      };
}
