import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/profile/components/info_card.dart';
import 'package:jeevamrut_app/Screens/profile/components/profile_pic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeevamrut_app/Screens/profile/profile_screen.dart';
import 'package:path/path.dart';

// our data
const sex = "male";
const email = "me.shivansh007@gmail.com";
const phone = "90441539202"; // not real number :)
const location = "Madhapur, Hyderabad";

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  File? file;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Details"),
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: Text("Edit Details"),
          onPressed: () {
            updateProfile(context);
          },
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[800],
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  _buildProfilePic(file),
                  InkWell(
                    onTap: () {
                      chooseImage();
                    },
                    child: Text(
                      "Upload New Image",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                  const Text(
                    "Shivansh Singh",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),

                  // we will be creating a new widget name info carrd
                  InfoCard(
                      text: email, icon: Icons.email, onPressed: () async {}),
                  InfoCard(
                      text: phone, icon: Icons.phone, onPressed: () async {}),
                  InfoCard(
                      text: sex, icon: Icons.person, onPressed: () async {}),
                  InfoCard(
                      text: location,
                      icon: Icons.location_city,
                      onPressed: () async {}),
                ],
              ),
            ]),
    );
  }

  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("file " + xfile!.path);
    file = File(xfile.path);
    setState(() {});
  }

  Future updateProfile(BuildContext context) async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> map = Map();
    if (file != null) {
      String url = await uploadImage();
      map['profileImage'] = url;
    }
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(
            FirebaseAuth.instance.currentUser!.uid + "_" + basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }
}

Widget _buildProfilePic(File? file) {
  return SizedBox(
    height: 115,
    width: 115,
    child: Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        file != null
            ? CircleAvatar(
                backgroundImage: Image.file(file).image,
              )
            : ProfilePic(),
      ],
    ),
  );
}
