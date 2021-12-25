import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:jeevamrut_app/models/product_response.dart';

class Cart extends Equatable {
  final List<String> productIds;

  const Cart({this.productIds = const []});

  @override
  List<Object?> get props => [productIds];

  Map productQuantity(List<String> productIds) {
    var quantity = Map();
    productIds.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  // double get subtotal =>
  //     products.fold(0, (total, current) => total + current.price!);

  // double deliveryFee(subtotal) {
  //   if (subtotal >= 30.0) {
  //     return 0.0;
  //   } else
  //     return 10.0;
  // }

  // String freeDelivery(subtotal) {
  //   if (subtotal >= 30.0) {
  //     return 'You have Free Delivery';
  //   } else {
  //     double missing = 30.0 - subtotal;
  //     return 'Add \$${missing.toStringAsFixed(2)} for FREE Delivery';
  //   }
  // }

  // double total(subtotal, deliveryFee) {
  //   return subtotal + deliveryFee(subtotal);
  // }

  // String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);

  // String get subtotalString => subtotal.toStringAsFixed(2);

  // String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  // String get freeDeliveryString => freeDelivery(subtotal);
}
