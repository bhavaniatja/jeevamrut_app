part of 'orderid_bloc.dart';

abstract class OrderidEvent extends Equatable {
  const OrderidEvent();

  @override
  List<Object> get props => [];
}

class LoadingOrderidEvent extends OrderidEvent {}

class LoadOrderid extends OrderidEvent {
  final String id;
  final double amount;
  LoadOrderid(this.id, this.amount);
  @override
  List<Object> get props => [id, amount];
}
