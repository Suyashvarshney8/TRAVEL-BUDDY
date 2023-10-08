import 'package:klndrive/auth/otpHome.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/semantics.dart';
import 'package:klndrive/auth/registerUser.dart';

class HomeSCreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeSCreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Buddy'),
      ),
      backgroundColor: Color.fromARGB(255, 221, 231, 232),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: 300.0,
                  width: 400.0,
                  child: const Align(
                    alignment: Alignment(0.05, 0.2),
                    child: Image(
                        width: 250,
                        height: 300,
                        image: AssetImage('assets/Pic.png')),
                  )),
            ),
            Container(
              height: 50.0,
              width: 250.0,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OtpHome()));
                },
                child: Text(
                  'Log in',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 10,
              width: 250,
            ),
            Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
