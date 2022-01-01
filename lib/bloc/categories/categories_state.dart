part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<ProductResponse> products;

  CategoriesLoaded({this.products = const <ProductResponse>[]});

  @override
  List<Object> get props => [products];
}
