import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ivoire_contacts/i_contacts/ContactHome.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => CtHome()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Container(
                child: Text(
                  "Ivoire Contacts",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 250),
            Center(child: Text("Loading...")),
            Padding(
              padding: const EdgeInsets.only(left: 150),
              child: Row(
                children: <Widget>[
                  SpinKitThreeBounce(
                    color: Colors.white,
                    size: 30.0,
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