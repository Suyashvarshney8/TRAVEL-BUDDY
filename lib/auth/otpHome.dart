import 'package:flutter/material.dart';
import 'package:klndrive/auth/otpPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpHome extends StatefulWidget {
  @override
  _OtpHomeState createState() => _OtpHomeState();
}

class _OtpHomeState extends State<OtpHome> {
  TextEditingController _controller = TextEditingController();

  bool _areFieldsFilled() {
    if (_controller.text.isEmpty) {
      _showToast("Please provide your number");
      return false;
    }
    return true;
  }

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
    );
  }

//   Future<bool> checkNumberIsRegistered({required String number}) async {
//     bool isNumberRegistered = false;
//     try {
//       await dbref.child("RegisteredNumbers").once().then((data) {
//         for (var i in data.snapshot.children) {
//           String data = i.child("phoneNo").value.toString();

//           if (number == data) {
//             isNumberRegistered = true;
//             return isNumberRegistered;
//           } else {
//             isNumberRegistered = false;
//           }
//         }
//       });
//       return isNumberRegistered;
//     } catch (e) {
//       return false;
//     }
//   }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 221, 231, 232),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: 200.0,
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
                  //   padding: EdgeInsets.fromLTRB(16.0, 80.0, 0.0, 0.0),
                  //   child: Text('Buddy',
                  //       style: TextStyle(
                  //           fontSize: 70.0, fontWeight: FontWeight.bold)),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.fromLTRB(255.0, 165.0, 0.0, 0.0),
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
              padding: EdgeInsets.fromLTRB(20, 70.0, 0.0, 0.0),
              child: Text(
                "Enter your registered \nmobile number to Login",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, right: 20, left: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  prefix: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('+91'),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 60.0,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green)),
                onPressed: () {
                  if (_areFieldsFilled()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OtpPage(
                              phone: _controller.text,
                            )));
                  }
                },
                child: Text(
                  'NEXT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170),
              child: Align(
                child: Text(
                  "©cp301",
                  style: TextStyle(color: Colors.grey),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
