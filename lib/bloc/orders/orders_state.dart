part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrdersResponse> orders;

  OrdersLoaded({this.orders = const <OrdersResponse>[]});

  @override
  List<Object> get props => [orders];
}
