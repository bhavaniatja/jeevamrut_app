import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductRepository _productRepository;

  CategoriesBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(CategoriesLoading()) {
    on<LoadingCategoriesEvent>((event, emit) {
      emit((CategoriesLoading()));
    });
    on<LoadCategories>((event, emit) async {
      print(event.category);
      final products = await _productRepository.getCategoriesFromApi(
          event.category, event.subCategory, event.pincode);
      emit((CategoriesLoaded(products: products)));
    });
  }
}
