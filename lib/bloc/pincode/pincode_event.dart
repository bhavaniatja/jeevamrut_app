part of 'pincode_bloc.dart';

abstract class PincodeEvent extends Equatable {
  const PincodeEvent();

  @override
  List<Object> get props => [];
}

class PincodeInitEvent extends PincodeEvent {}

class PincodeEditEvent extends PincodeEvent {
  final String pincode;
  PincodeEditEvent(this.pincode);
}

class PincodeEditedEvent extends PincodeEvent {
  final String pincode;
  PincodeEditedEvent(this.pincode);
}
