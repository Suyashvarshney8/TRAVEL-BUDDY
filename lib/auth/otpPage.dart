import 'package:flutter/material.dart';

import 'package:klndrive/HomeScreen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinput/pinput.dart';
import 'package:klndrive/auth/registerUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpPage extends StatefulWidget {
  final String? phone;
  OtpPage({this.phone});
  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  String? uid;
  final _auth = FirebaseAuth.instance;
  late String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.circular(15.0),
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  var defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 221, 231, 232),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: 200,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                    child: Text('Travel',
                        style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Buddy',
                        style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                  //   child: Text('Share',
                  //       style: TextStyle(
                  //           fontSize: 70.0, fontWeight: FontWeight.bold)),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(16.0, 125.0, 0.0, 0.0),
                  //   child: Text('MyRide',
                  //       style: TextStyle(
                  //           fontSize: 70.0, fontWeight: FontWeight.bold)),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(255.0, 115.0, 0.0, 0.0),
                  //   child: Text('.',
                  //       style: TextStyle(
                  //           fontSize: 80.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.blue)),
                  // ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 40.0, 0.0, 0.0),
              child: Text(
                "",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10.0, 20.0, 0.0),
              child: RichText(
                text: TextSpan(
                  text: 'We have sent a verification code sent to  ',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "+91 ${widget.phone}",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image(
                    image: AssetImage('assets/otp_icon.png'),
                    height: 120.0,
                    width: 120.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Pinput(
                      length: 6,
                      //eachFieldHeight: 40.0,
                      // withCursor: true,
                      onCompleted: (pin) async {
                        try {
                          await _auth
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode,
                                      smsCode: pin))
                              .then((value) async {
                            if (value.user != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            }
                          });
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid OTP")));
                        }
                      },
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      defaultPinTheme: defaultPinTheme = PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(30, 60, 87, 1),
                            fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(187, 192, 195, 1)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: Color.fromRGBO(217, 222, 226, 1),
                        ),
                      ),
                      focusedPinTheme: defaultPinTheme.copyDecorationWith(
                        border:
                            Border.all(color: Color.fromRGBO(22, 138, 13, 1)),
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                  child: Row(
                    children: [
                      Text(
                        "Didn't receive OTP ?",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        child: Text(
                          " Resend OTP",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => _verifyPhone(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await _auth.verifyPhoneNumber(
      timeout: Duration(seconds: 60),
      phoneNumber: '+91${widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) async {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          var status = sharedPreferences.getBool('isLoggedIn') ?? false;
          if (status) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verficationID, int? resendToken) {
        setState(() {
          _verificationCode = verficationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
    );
  }
}
