import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:jeevamrut_app/constants.dart';
import 'package:jeevamrut_app/models/track_order.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text("Track Your Order",
            style: TextStyle(color: Colors.deepOrange, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                "Wed, 12 September",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Order ID : 5136 - 9ui2 - 129i2",
                style: TextStyle(
                  fontSize: 18.0,
                  color: kLightColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Text(
                "Orders",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.9,
                  width: MediaQuery.of(context).size.width / 6,
                  child: IconStepper(
                    direction: Axis.vertical,
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                    stepColor: Colors.green,
                    activeStepBorderColor: kWhiteColor,
                    activeStepBorderWidth: 0.0,
                    activeStepBorderPadding: 0.0,
                    lineColor: Colors.green,
                    lineLength: 70.0,
                    lineDotRadius: 2.0,
                    stepRadius: 16.0,
                    icons: const [
                      Icon(Icons.radio_button_checked, color: Colors.green),
                      Icon(Icons.check, color: kWhiteColor),
                      Icon(Icons.check, color: kWhiteColor),
                      Icon(Icons.check, color: kWhiteColor),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16.0),
                              leading: Icon(
                                trackOrderList[index].icon,
                                size: 48.0,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                trackOrderList[index].title!,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Text(
                                trackOrderList[index].subtitle!,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Text(
                            trackOrderList[index].time!,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding:
                  const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(
                  width: 0.5,
                  color: kLightColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.home, size: 64.0, color: kPrimaryColor),
                  const SizedBox(width: 32.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Address",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "Home, Work & Other Address",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: kDarkColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Text(
                          "House No: 1234, 2nd Floor Sector 18, Silicon Valey Amerika Serikat",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: kDarkColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
