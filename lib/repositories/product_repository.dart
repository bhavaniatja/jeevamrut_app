import 'dart:convert';
import 'dart:io';

import 'package:jeevamrut_app/models/address_response.dart';
import 'package:jeevamrut_app/models/orders_response.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/services/product_data.dart';

class ProductRepository {
  Future<List<ProductResponse>> getProductsFromApi(String pincode) async {
    try {
      final response = await HttpService.getRequest(pincode);
      // print(response.body);
      var products = <ProductResponse>[];
      if (response.statusCode == 200) {
        var content = json.decode(response.body);
        var prodJson = content["content"];
        for (var prodJson in prodJson) {
          products.add(ProductResponse.fromJson(prodJson));
        }
        print(products);
        return products;
      } else {
        return <ProductResponse>[];
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }

  Future<List<ProductResponse>> getCategoriesFromApi(
      String category, String subCategory, String pincode) async {
    try {
      final response = await HttpService.getRequestCategories(
          category, subCategory, pincode);
      // print(response.body);
      var products = <ProductResponse>[];
      if (response.statusCode == 200) {
        var content = json.decode(response.body);
        var prodJson = content["content"];
        print(prodJson);
        for (var prodJson in prodJson) {
          products.add(ProductResponse.fromJson(prodJson));
        }

        return products;
      } else {
        return <ProductResponse>[];
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }

  Future<AddressResponse> getAddressFromApi(String uid) async {
    try {
      final response = await HttpService.getRequestAddress(uid);

      var address = <AddressResponse>[];
      if (response.statusCode == 200) {
        var prodJson = json.decode(response.body);
        return AddressResponse.fromJson(prodJson);
      } else {
        return AddressResponse();
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }

  Future<List<OrdersResponse>> getOrdersFromApi() async {
    try {
      final response = await HttpService.getRequestOrders();
      var orders = <OrdersResponse>[];
      if (response.statusCode == 200) {
        if (response.contentLength! <= 2) {
          return <OrdersResponse>[];
        } else {
          var prodJson = json.decode(response.body);
          var ordersJson = prodJson["content"];
          for (var order in ordersJson) {
            orders.add(OrdersResponse.fromJson(order));
          }
          return orders;
        }
      } else {
        return <OrdersResponse>[];
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    }
  }
}
