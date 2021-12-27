import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jeevamrut_app/models/firebaseuser.dart';
import 'package:jeevamrut_app/models/user_mode.dart';
import 'package:http/http.dart' as http;

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
    http.Response usercheckresponse;
    // bool check = false;
    final checkuser = Uri.parse(
        "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/api/user/${user!.uid}");
    print(checkuser);
    try {
      usercheckresponse = await http.get(checkuser);
      if (usercheckresponse.statusCode == 200) {
        String data = json.encode(usercheckresponse.body);
        print(data.length);
        if (data.length <= 2) {
          print("empty");
          postToAws(user.uid, user.phoneNumber);
        } else {
          print("user exists already");
        }
      }
    } on Exception catch (e) {
      throw e;
    }

    var a = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
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

void postToAws(String uid, String? mobile) async {
  print(uid + " " + mobile!);
  final response;
  const String endPoint =
      "http://ec2-18-188-87-26.us-east-2.compute.amazonaws.com:8080/api/user";
  final Uri url = Uri.parse(endPoint);
  Map body = {
    "id": uid,
    "fname": "Default fname",
    "lname": "Default lname",
    "email": "bhavani9@gmail.com",
    "mobileNumber": mobile,
    "altMobileNumber": null,
    "mobileVerified": 0,
    "altMobileVerified": 0,
    "role": "user",
    "active": 1,
    "language": "en",
    "meta": "{\"name\": \"bhav\"}",
    "createDate": "2021-12-23T10:45:54.000+00:00",
    "createdBy": "Mohan",
    "updatedDate": "2021-12-23T10:45:54.000+00:00",
    "updatedBy": "Kiran"
  };
  try {
    var payload = json.encode(body);
    response = await http.post(
      url,
      body: payload,
      headers: {
        "Content-Type": "application/json",
        "Content-Length": "${payload.length}"
      },
    );
    print(payload.length);
    var data = response.body;
    print(data);
    if (response.statusCode == 200) {
      print("jii");
    }
  } on Exception catch (e) {
    print(e);
    throw e;
  }
}
