import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/models/user_mode.dart';

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
      final authCredential = await _auth
          .signInWithCredential(phoneAuthCredential)
          .then((value) => postDetailsToFirestore());

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

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    var a = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (!a.exists) {
      UserModel userModel = UserModel();
      userModel.uid = user.uid;
      userModel.mobile = user.phoneNumber;
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
    }
  }
}
