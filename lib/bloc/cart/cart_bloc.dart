import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jeevamrut_app/bloc/bloc/product_bloc.dart';
import 'package:jeevamrut_app/models/cart_response.dart';
import 'package:jeevamrut_app/models/product_response.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    // add(CartStarted());
    on<CartStarted>((event, emit) {
      emit(CartLoaded());
      print(state);
    });
    on<CartProductAdded>((event, Emitter<CartState> emit) {
      _checkAdded(event, emit);
    });
    on<CartProductRemoved>((event, emit) {
      try {
        emit(CartLoaded(
          cart: Cart(
            products: List.from((state as CartLoaded).cart.products)
              ..remove(event.product),
          ),
        ));
        print((state as CartLoaded).cart.products);
      } on Exception {
        emit(CartError());
      }
    });
  }
  void _checkAdded(CartProductAdded event, Emitter<CartState> emit) {
    emit(CartLoaded(
      cart: Cart(
        products: List.from((state as CartLoaded).cart.products)
          ..add(event.product),
      ),
    ));
    print((state as CartLoaded).cart.products);
  }
}
