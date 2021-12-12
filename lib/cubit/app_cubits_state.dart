part of 'app_cubits_cubit.dart';

@immutable
abstract class AppCubitsState extends Equatable {}

class AppInitial extends AppCubitsState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AppCubitsState {
  // ignore: prefer_typing_uninitialized_variables
  final message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [];
}

class AppLoading extends AppCubitsState {
  @override
  List<Object?> get props => [];
}

class AppLoaded extends AppCubitsState {
  final List<ProductResponse> productresponse;
  AppLoaded(this.productresponse);
  @override
  List<Object?> get props => [productresponse];
}

class AddressLoaded extends AppCubitsState {
  final AddressResponse addressresponse;
  AddressLoaded(this.addressresponse);
  @override
  List<Object?> get props => [addressresponse];
}
