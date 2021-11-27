import 'package:flutter/material.dart';
import 'package:jeevamrut_app/Screens/orders/components/track_order.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Your Order #23838 is Successful",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TrackOrderScreen()));
              },
              child: Text("Track Your Order")),
        ],
      ),
    );
  }
}
