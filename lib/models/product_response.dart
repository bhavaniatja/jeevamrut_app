import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.id,
    this.name,
    this.brandName,
    this.quantity,
    this.price,
    this.taxCategoryId,
    this.description,
    this.category,
    this.subCategory,
    this.manufactureDate,
    this.expiryDate,
    this.noExpiry,
    this.isAvailable,
    this.locationCategory,
    this.meta,
    this.productImage,
  });

  String? id;
  String? name;
  String? brandName;
  String? quantity;
  int? price;
  String? taxCategoryId;
  String? description;
  String? category;
  String? subCategory;
  DateTime? manufactureDate;
  dynamic expiryDate;
  int? noExpiry;
  int? isAvailable;
  String? locationCategory;
  String? meta;
  ProductImage? productImage;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        id: json["id"],
        name: json["name"],
        brandName: json["brand_name"],
        quantity: json["quantity"],
        price: json["price"],
        taxCategoryId: json["tax_category_id"],
        description: json["description"],
        category: json["category"],
        subCategory: json["sub_category"],
        manufactureDate: DateTime.parse(json["manufacture_date"]),
        expiryDate: json["expiry_date"],
        noExpiry: json["no_expiry"],
        isAvailable: json["is_available"],
        locationCategory: json["location_category"],
        meta: json["meta"],
        productImage: ProductImage.fromJson(json["product_image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand_name": brandName,
        "quantity": quantity,
        "price": price,
        "tax_category_id": taxCategoryId,
        "description": description,
        "category": category,
        "sub_category": subCategory,
        "manufacture_date":
            "${manufactureDate!.year.toString().padLeft(4, '0')}-${manufactureDate!.month.toString().padLeft(2, '0')}-${manufactureDate!.day.toString().padLeft(2, '0')}",
        "expiry_date": expiryDate,
        "no_expiry": noExpiry,
        "is_available": isAvailable,
        "location_category": locationCategory,
        "meta": meta,
        "product_image": productImage!.toJson(),
      };
}

class ProductImage {
  ProductImage({
    this.id,
    this.productId,
    this.imageUrl,
    this.format,
  });

  String? id;
  String? productId;
  String? imageUrl;
  String? format;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        productId: json["product_id"],
        imageUrl: json["image_url"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_url": imageUrl,
        "format": format,
      };
}
