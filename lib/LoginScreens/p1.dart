import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notess/pages/homepage.dart';

import 'p5.dart';

//Future (async , await,then())
//Stream- Based on Reactive Programming (Real Time)

FirebaseAuth _auth = FirebaseAuth.instance;

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // if(snapshot.hasData){
        //   final user = snapshot.data;
        //   if(user == null){
        //     return SingInScreen();
        //   }
        //   return HomeScreen();
        // }
        //
        // return Scaffold(
        //   body: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // );

        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;

          if (user == null) {
            return SignInScreen(auth: _auth);
          } else
            return HomePage(auth: _auth);
        }
        // return EmailVerifyScreen(auth: _auth);

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
