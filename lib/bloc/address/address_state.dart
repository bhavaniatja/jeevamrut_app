part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressLoading extends AddressState {}

class AddressEditState extends AddressState {}

class AddressEditedState extends AddressState {}

class AddressLoaded extends AddressState {
  final AddressResponse Address;

  AddressLoaded(this.Address);

  @override
  List<Object> get props => [Address];
}
