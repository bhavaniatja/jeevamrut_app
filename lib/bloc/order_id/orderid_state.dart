part of 'orderid_bloc.dart';

abstract class OrderidState extends Equatable {
  const OrderidState();

  @override
  List<Object> get props => [];
}

class OrderidLoading extends OrderidState {}

class OrderidLoaded extends OrderidState {
  final OrderId orderId;
  const OrderidLoaded({required this.orderId});
  @override
  List<Object> get props => [orderId];
}
