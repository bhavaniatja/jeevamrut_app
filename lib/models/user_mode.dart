import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? mobile;
  String? profileImage;
  var timeStamp;

  UserModel({
    this.uid,
    this.mobile,
    this.profileImage,
    this.timeStamp,
  });

  // data from server parsing
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      mobile: map['mobile'],
      profileImage: map['profileImage'],
      timeStamp: map['timeStamp'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'mobile': mobile,
      'profileImage': profileImage,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }
}
