import 'dart:convert';
import 'dart:io';

import 'package:jeevamrut_app/models/address_response.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/services/product_data.dart';

class ProductRepository {
  Future<List<ProductResponse>> getProductsFromApi() async {
    try {
      final response = await HttpService.getRequest();
      var products = <ProductResponse>[];
      if (response.statusCode == 200) {
        var prodJson = json.decode(response.body);
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

  Future<AddressResponse> getAddressFromApi() async {
    try {
      final response = await HttpService.getRequestAddress();

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
}
