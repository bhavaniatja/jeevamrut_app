import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jeevamrut_app/models/orders_response.dart';
import 'package:jeevamrut_app/repositories/product_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final ProductRepository _productRepository;
  OrdersBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(OrdersLoading()) {
    on<LoadingOrdersEvent>((event, emit) {
      emit(OrdersLoading());
    });
    on<LoadOrders>((event, emit) async {
      final orders = await _productRepository.getOrdersFromApi();
      emit((OrdersLoaded(orders: orders)));
    });
  }
}
