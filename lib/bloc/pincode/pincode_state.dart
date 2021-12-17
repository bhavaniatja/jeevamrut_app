part of 'pincode_bloc.dart';

abstract class PincodeState extends Equatable {
  const PincodeState();

  @override
  List<Object> get props => [];
}

class PincodeInitial extends PincodeState {}

class PincodeEditState extends PincodeState {
  final String pincode;
  const PincodeEditState({required this.pincode});
}

class PincodeEditedState extends PincodeState {
  final String pincode;
  const PincodeEditedState({required this.pincode});
}
