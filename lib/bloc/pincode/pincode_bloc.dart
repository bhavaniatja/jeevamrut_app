import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jeevamrut_app/repositories/get_location.dart';

part 'pincode_event.dart';
part 'pincode_state.dart';

class PincodeBloc extends Bloc<PincodeEvent, PincodeState> {
  // GetLocationRepository _getLocationRepository;
  PincodeBloc() : super(PincodeInitial()) {
    on<PincodeInitEvent>((event, emit) async {
      emit((PincodeInitial()));
    });
    on<PincodeEditEvent>((event, emit) async {
      emit(PincodeEditState(pincode: event.pincode));
    });
    on<PincodeEditedEvent>((event, emit) async {
      emit(PincodeEditedState(pincode: event.pincode));
    });
  }
}
