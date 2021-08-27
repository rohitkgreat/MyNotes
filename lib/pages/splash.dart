import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notess/LoginScreens/FirstScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingScreen())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'MyNotess',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
