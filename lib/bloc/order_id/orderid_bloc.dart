import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jeevamrut_app/models/order_id.dart';

part 'orderid_event.dart';
part 'orderid_state.dart';

class OrderidBloc extends Bloc<OrderidEvent, OrderidState> {
  OrderidBloc() : super(OrderidLoading()) {
    on<LoadingOrderidEvent>((event, emit) {
      emit((OrderidLoading()));
    });
    on<LoadOrderid>((event, emit) {
      emit((OrderidLoaded(
          orderId: OrderId(id: event.id, amount: event.amount))));
    });
  }
}
