part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressEvent {}

class LoadAddress extends AddressEvent {
  final String uid;
  const LoadAddress(this.uid);
  @override
  List<Object> get props => [uid];
}

class AddressEditing extends AddressEvent {}

class AddressEdited extends AddressEvent {}
