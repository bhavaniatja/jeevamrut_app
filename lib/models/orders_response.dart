// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

OrdersResponse ordersResponseFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse data) => json.encode(data.toJson());

class OrdersResponse {
  OrdersResponse({
    this.id,
    this.userId,
    this.orderProducts,
    this.totalPrice,
    this.cgstTax,
    this.sgstTax,
    this.igstTax,
    this.discount,
    this.paymentId,
    this.promisedDate,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.status,
    this.deliveryFee,
  });

  String? id;
  String? userId;
  List<OrderProduct>? orderProducts;
  double? totalPrice;
  double? cgstTax;
  double? sgstTax;
  double? igstTax;
  double? discount;
  String? paymentId;
  DateTime? promisedDate;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  dynamic status;
  dynamic deliveryFee;

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        id: json["id"],
        userId: json["userId"],
        orderProducts: List<OrderProduct>.from(
            json["orderProducts"].map((x) => OrderProduct.fromJson(x))),
        totalPrice: json["totalPrice"],
        cgstTax: json["cgstTax"],
        sgstTax: json["sgstTax"],
        igstTax: json["igstTax"],
        discount: json["discount"],
        paymentId: json["paymentId"],
        promisedDate: DateTime.parse(json["promisedDate"]),
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
        status: json["status"],
        deliveryFee: json["deliveryFee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "orderProducts":
            List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "cgstTax": cgstTax,
        "sgstTax": sgstTax,
        "igstTax": igstTax,
        "discount": discount,
        "paymentId": paymentId,
        "promisedDate": promisedDate!.toIso8601String(),
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
        "status": status,
        "deliveryFee": deliveryFee,
      };
}

class OrderProduct {
  OrderProduct({
    this.id,
    this.productId,
    this.orderId,
    this.amount,
    this.discount,
    this.quantity,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.status,
    this.deliveryFee,
  });

  String? id;
  dynamic productId;
  dynamic orderId;
  double? amount;
  double? discount;
  int? quantity;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  dynamic status;
  dynamic deliveryFee;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        productId: json["productId"],
        orderId: json["orderId"],
        amount: json["amount"],
        discount: json["discount"],
        quantity: json["quantity"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
        status: json["status"],
        deliveryFee: json["deliveryFee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "orderId": orderId,
        "amount": amount,
        "discount": discount,
        "quantity": quantity,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
        "status": status,
        "deliveryFee": deliveryFee,
      };
}
