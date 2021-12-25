part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartStarted extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartProductAdded extends CartEvent {
  final String productId;

  const CartProductAdded(this.productId);

  @override
  List<Object> get props => [productId];
}

class CartProductRemoved extends CartEvent {
  final String productId;

  const CartProductRemoved(this.productId);

  @override
  List<Object> get props => [productId];
}

class CartTrigger extends CartEvent {
  final List<ProductResponse> products;
  const CartTrigger(this.products);
  @override
  List<Object> get props => [products];
}
