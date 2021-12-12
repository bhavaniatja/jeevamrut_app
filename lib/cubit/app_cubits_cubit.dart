import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jeevamrut_app/models/address_response.dart';
import 'package:jeevamrut_app/models/product_response.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'app_cubits_state.dart';

class AppCubitsCubit extends Cubit<AppCubitsState> {
  final ProductRepository productdata;
  AppCubitsCubit({required this.productdata}) : super(AppInitial());
  dynamic products = [];
  dynamic address = [];
  Future getData() async {
    emit(AppLoading());
    try {
      products = await productdata.getProductsFromApi();
      if (products == []) {
        emit(ErrorState("There is some issue"));
      } else {
        emit(AppLoaded(products));
        emit(AppInitial());
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future getAddress() async {
    emit(AppLoading());
    print("inside");
    try {
      address = await productdata.getAddressFromApi();
      print(address);
      if (address == "") {
        emit(ErrorState("There is some issue"));
        print("Nothing");
      } else {
        emit(AddressLoaded(address));
        emit(AppInitial());
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
