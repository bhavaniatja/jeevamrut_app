// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.id,
    this.name,
    this.prices,
    this.productImage,
    this.brandName,
    this.quantity,
    this.taxCategoryId,
    this.vendorId,
    this.description,
    this.category,
    this.subCategory,
    this.manufactureDate,
    this.expiryDate,
    this.available,
    this.threshold,
    this.pinCode,
    this.locationCategory,
    this.meta,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.version,
  });

  String? id;
  String? name;
  List<Price>? prices;
  ProductImage? productImage;
  String? brandName;
  String? quantity;
  String? taxCategoryId;
  String? vendorId;
  String? description;
  String? category;
  String? subCategory;
  DateTime? manufactureDate;
  DateTime? expiryDate;
  int? available;
  int? threshold;
  String? pinCode;
  String? locationCategory;
  String? meta;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  String? version;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        id: json["id"],
        name: json["name"],
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        productImage: ProductImage.fromJson(json["productImage"]),
        brandName: json["brandName"],
        quantity: json["quantity"],
        taxCategoryId: json["taxCategoryId"],
        vendorId: json["vendorId"],
        description: json["description"],
        category: json["category"],
        subCategory: json["subCategory"],
        manufactureDate: DateTime.parse(json["manufactureDate"]),
        expiryDate: DateTime.parse(json["expiryDate"]),
        available: json["available"],
        threshold: json["threshold"],
        pinCode: json["pinCode"],
        locationCategory: json["locationCategory"],
        meta: json["meta"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "prices": List<dynamic>.from(prices!.map((x) => x.toJson())),
        "productImage": productImage!.toJson(),
        "brandName": brandName,
        "quantity": quantity,
        "taxCategoryId": taxCategoryId,
        "vendorId": vendorId,
        "description": description,
        "category": category,
        "subCategory": subCategory,
        "manufactureDate": manufactureDate!.toIso8601String(),
        "expiryDate": expiryDate!.toIso8601String(),
        "available": available,
        "threshold": threshold,
        "pinCode": pinCode,
        "locationCategory": locationCategory,
        "meta": meta,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
        "version": version,
      };
}

class Price {
  Price({
    this.id,
    this.productId,
    this.price,
    this.type,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  String? id;
  dynamic? productId;
  int? price;
  String? type;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        id: json["id"],
        productId: json["productId"],
        price: json["price"],
        type: json["type"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "price": price,
        "type": type,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}

class ProductImage {
  ProductImage({
    this.id,
    this.productId,
    this.imageUrl,
    this.format,
    this.source,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  String? id;
  dynamic? productId;
  String? imageUrl;
  String? format;
  String? source;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        productId: json["productId"],
        imageUrl: json["imageUrl"],
        format: json["format"],
        source: json["source"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "imageUrl": imageUrl,
        "format": format,
        "source": source,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
