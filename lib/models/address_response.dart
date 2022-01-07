// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'dart:convert';

AddressResponse addressResponseFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) =>
    json.encode(data.toJson());

class AddressResponse {
  AddressResponse({
    this.id,
    this.userId,
    this.fname,
    this.lname,
    this.email,
    this.wallet,
    this.address,
    this.mobileNumber,
    this.altMobileNumber,
    this.mobileVerified,
    this.altMobileVerified,
    this.role,
    this.active,
    this.language,
    this.meta,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  dynamic id;
  String? userId;
  String? fname;
  String? lname;
  String? email;
  Wallet? wallet;
  Address? address;
  String? mobileNumber;
  String? altMobileNumber;
  int? mobileVerified;
  int? altMobileVerified;
  String? role;
  int? active;
  String? language;
  String? meta;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["id"],
        userId: json["userId"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        wallet: Wallet.fromJson(json["wallet"]),
        address: Address.fromJson(json["address"]),
        mobileNumber: json["mobileNumber"],
        altMobileNumber: json["altMobileNumber"],
        mobileVerified: json["mobileVerified"],
        altMobileVerified: json["altMobileVerified"],
        role: json["role"],
        active: json["active"],
        language: json["language"],
        meta: json["meta"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "fname": fname,
        "lname": lname,
        "email": email,
        "wallet": wallet!.toJson(),
        "address": address!.toJson(),
        "mobileNumber": mobileNumber,
        "altMobileNumber": altMobileNumber,
        "mobileVerified": mobileVerified,
        "altMobileVerified": altMobileVerified,
        "role": role,
        "active": active,
        "language": language,
        "meta": meta,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}

class Address {
  Address({
    this.id,
    this.type,
    this.preference,
    this.buildingName,
    this.apartmentNumber,
    this.streetName,
    this.landmark,
    this.billingAddress,
    this.shippingAddress,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.mobile,
    this.alternateMobile,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  String? id;
  String? type;
  int? preference;
  String? buildingName;
  String? apartmentNumber;
  String? streetName;
  String? landmark;
  int? billingAddress;
  int? shippingAddress;
  String? city;
  String? state;
  String? country;
  dynamic pincode;
  String? mobile;
  String? alternateMobile;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        type: json["type"],
        preference: json["preference"],
        buildingName: json["buildingName"],
        apartmentNumber: json["apartmentNumber"],
        streetName: json["streetName"],
        landmark: json["landmark"],
        billingAddress: json["billingAddress"],
        shippingAddress: json["shippingAddress"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        mobile: json["mobile"],
        alternateMobile: json["alternateMobile"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "preference": preference,
        "buildingName": buildingName,
        "apartmentNumber": apartmentNumber,
        "streetName": streetName,
        "landmark": landmark,
        "billingAddress": billingAddress,
        "shippingAddress": shippingAddress,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "mobile": mobile,
        "alternateMobile": alternateMobile,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}

class Wallet {
  Wallet({
    this.id,
    this.amount,
    this.type,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.walletTransactions,
  });

  String? id;
  double? amount;
  String? type;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  List<WalletTransaction>? walletTransactions;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
        walletTransactions: List<WalletTransaction>.from(
            json["walletTransactions"]
                .map((x) => WalletTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
        "walletTransactions":
            List<dynamic>.from(walletTransactions!.map((x) => x.toJson())),
      };
}

class WalletTransaction {
  WalletTransaction({
    this.id,
    this.orderId,
    this.walletId,
    this.amount,
    this.currentBalance,
    this.previousBalance,
    this.type,
    this.description,
    this.status,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  String? id;
  String? orderId;
  dynamic walletId;
  double? amount;
  double? currentBalance;
  double? previousBalance;
  String? type;
  String? description;
  String? status;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      WalletTransaction(
        id: json["id"],
        orderId: json["orderId"],
        walletId: json["walletId"],
        amount: json["amount"],
        currentBalance: json["currentBalance"],
        previousBalance: json["previousBalance"],
        type: json["type"],
        description: json["description"],
        status: json["status"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "walletId": walletId,
        "amount": amount,
        "currentBalance": currentBalance,
        "previousBalance": previousBalance,
        "type": type,
        "description": description,
        "status": status,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
