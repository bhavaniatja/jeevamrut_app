import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jeevamrut_app/models/address_response.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final ProductRepository _productRepository;
  AddressBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(AddressLoading()) {
    on<AddressInitial>((event, emit) {
      emit(AddressLoading());
    });
    on<LoadAddress>((event, emit) async {
      final address = await _productRepository.getAddressFromApi(event.uid);
      emit((AddressLoaded(address)));
      // Future.delayed(Duration(seconds: 4));
      // emit((AddressLoading()));
    });
    on<AddressEditing>((event, emit) {
      emit((AddressEditState()));
    });
    on<AddressEdited>((event, emit) {
      emit((AddressEditedState()));
    });
  }
}
