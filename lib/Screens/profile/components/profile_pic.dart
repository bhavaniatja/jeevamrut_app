import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jeevamrut_app/models/user_mode.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .get()
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromMap(snapshot.data);
            return SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  userModel.profileImage == null
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/Profile Image.png"),
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(userModel.profileImage!),
                        ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
