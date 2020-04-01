//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:founder/Login.dart';
import 'dart:async';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartLandingPage();
  }
}

class StartLandingPage extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Login()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Text("this is just a landing page"),
        )
    );
  }
}

