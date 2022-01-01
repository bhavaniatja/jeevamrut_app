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
    this.user,
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
    this.pinCode,
    this.mobile,
    this.alternateMobile,
    this.createDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  String? id;
  String? user;
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
  String? pinCode;
  String? mobile;
  String? alternateMobile;
  DateTime? createDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["id"],
        user: json["user"],
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
        pinCode: json["pinCode"],
        mobile: json["mobile"],
        alternateMobile: json["alternateMobile"],
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
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
        "pinCode": pinCode,
        "mobile": mobile,
        "alternateMobile": alternateMobile,
        "createDate": createDate!.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate!.toIso8601String(),
        "updatedBy": updatedBy,
      };
}
