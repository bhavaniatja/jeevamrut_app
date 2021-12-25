part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadingProductEvent extends ProductEvent {}

class LoadProducts extends ProductEvent {
  final String pincode;
  LoadProducts(this.pincode);
  @override
  List<Object> get props => [pincode];
}

class UpdateProducts extends ProductEvent {
  final List<ProductResponse> products;

  UpdateProducts(this.products);

  @override
  List<Object> get props => [products];
}
