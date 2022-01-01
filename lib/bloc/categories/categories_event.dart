part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadingCategoriesEvent extends CategoriesEvent {}

class LoadCategories extends CategoriesEvent {
  final String category;
  final String subCategory;
  final String pincode;
  LoadCategories(this.category, this.subCategory, this.pincode);
  @override
  List<Object> get props => [category, subCategory, pincode];
}
