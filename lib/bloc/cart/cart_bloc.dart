import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/models/cart_response.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    // add(CartStarted());
    on<CartStarted>((event, emit) {
      emit(CartLoaded());
      // print(state);
    });
    // on<CartTrigger>((event, emit) {
    //   emit(CartLoaded(cart: Cart(products: event.products)));
    // });
    on<CartProductAdded>((event, Emitter<CartState> emit) {
      _checkAdded(event, emit);
    });
    on<CartProductRemoved>((event, emit) async {
      try {
        emit(CartLoaded(
          cart: Cart(
            productIds: List.from((state as CartLoaded).cart.productIds)
              ..remove(event.productId),
          ),
        ));
        // Future.delayed(Duration(seconds: 1));
        await _addData();
      } on Exception {
        emit(CartError());
      }
    });
  }
  void _checkAdded(CartProductAdded event, Emitter<CartState> emit) async {
    emit(CartLoaded(
      cart: Cart(
        productIds: List.from((state as CartLoaded).cart.productIds)
          ..add(event.productId),
      ),
    ));
    // Future.delayed(Duration(seconds: 1));
    await _addData();

    // print(pref.getStringList('cart'));
  }

  Future<void> _addData() async {
    List<String> list = [];
    var data = (state as CartLoaded).cart.productIds;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('cart', data);
    List<String> lst = pref.getStringList('cart')!;
    // print(lst);
  }
}
