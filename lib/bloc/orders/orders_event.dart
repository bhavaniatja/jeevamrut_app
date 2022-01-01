part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class LoadingOrdersEvent extends OrdersEvent {}

class LoadOrders extends OrdersEvent {}
