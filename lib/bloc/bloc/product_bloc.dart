import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  // StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadingProductEvent>((event, emit) {
      emit((ProductLoading()));
    });
    on<LoadProducts>((event, emit) async {
      final products = await _productRepository.getProductsFromApi();
      emit((ProductLoaded(products: products)));
    });
  }

  // Stream<ProductState> mapEventToState(
  //   ProductEvent event,
  // ) async* {
  //   if (event is LoadProducts) {
  //     yield* _mapLoadProductsToState();
  //   }
  // }

  // Stream<ProductState> _mapLoadProductsToState() async* {

  //   yield
  // }
}
