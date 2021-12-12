import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  static const String routeName = "/auth";
  String defaultFontFamily = 'Roboto-Light.ttf';
  double defaultFontSize = 14;
  double defaultIconSize = 17;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        var phone = (authCredential.user!.phoneNumber).toString();

        // SharedPreferences pref = await SharedPreferences.getInstance();
        // pref.setString('phone', phone);
        Navigator.pushNamed(context, '/');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
      width: double.infinity,
      height: double.infinity,
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/jeevamrut_logo.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: phoneController,
                  showCursor: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: const Color(0xFF666666),
                      size: defaultIconSize,
                    ),
                    fillColor: const Color(0xFFF2F3F5),
                    hintStyle: TextStyle(
                        color: const Color(0xFF666666),
                        fontFamily: defaultFontFamily,
                        fontSize: defaultFontSize),
                    hintText: "Phone Number",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: const EdgeInsets.all(17.0),
                    onPressed: () async {
                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                        phoneNumber: "+91${phoneController.text}",
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
                          //signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: Text(verificationFailed.message!)));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            currentState =
                                MobileVerificationState.SHOW_OTP_FORM_STATE;
                            this.verificationId = verificationId;
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    },
                    child: const Text(
                      "Get Otp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins-Medium.ttf',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    color: const Color(0xFFBC1F26),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Color(0xFFBC1F26))),
                  ),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: InkWell(
            child: Container(
              child: const Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.arrow_back_ios_new),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          // flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 130,
                height: 130,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/jeevamrut_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              // Text("${widget.phone}"),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: otpController,
                showCursor: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                      color: Color(0xFF666666),
                      fontFamily: defaultFontFamily,
                      fontSize: defaultFontSize),
                  hintText: "Otp",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.all(17.0),
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: otpController.text);

                    signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins-Medium.ttf',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  color: Color(0xFFBC1F26),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      side: BorderSide(color: Color(0xFFBC1F26))),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}
//https://www.youtube.com/watch?v=W19IfZ-nqB8