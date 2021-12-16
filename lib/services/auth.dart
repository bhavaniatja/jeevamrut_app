import 'package:firebase_auth/firebase_auth.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser? _authUserFromFirebase(User? user) {
    return user != null ? FirebaseUser(id: user.uid) : null;
  }

  // auth change user strea
  Stream<FirebaseUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _authUserFromFirebase(user!));
  }

  Future signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      // if (authCredential.user != null) {
      // var phone = (authCredential.user!.phoneNumber).toString();
      return _authUserFromFirebase(authCredential.user);
      //   // Navigator.pushNamed(context, '/');
      // }
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }
}
