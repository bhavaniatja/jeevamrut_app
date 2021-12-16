import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/services/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoading>((event, emit) {
      emit(AuthInitial());
    });
    on<AuthLoggedIn>((event, emit) {
      final user = AuthService().user;
      emit(AuthLoggedState(user: user));
    });
  }
}
