part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoggedState extends AuthState {
  final Stream<FirebaseUser?>? user;
  AuthLoggedState({this.user});
}

class AuthLogOutState extends AuthState {}
