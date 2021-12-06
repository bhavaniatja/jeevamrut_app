import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/profile/components/info_card.dart';
import 'package:jeevamrut_app/Screens/profile/components/profile_pic.dart';

// our data
const sex = "male";
const email = "me.shivansh007@gmail.com";
const phone = "90441539202"; // not real number :)
const location = "Madhapur, Hyderabad";

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

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
          onPressed: () {},
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[800],
      body: ListView(children: [
        SizedBox(
          height: 20,
        ),
        Column(
          children: <Widget>[
            const ProfilePic(),
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
            InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
            InfoCard(text: sex, icon: Icons.person, onPressed: () async {}),
            InfoCard(
                text: location,
                icon: Icons.location_city,
                onPressed: () async {}),
          ],
        ),
      ]),
    );
  }
}
