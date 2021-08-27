import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'p2.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  _signInWithGoogle() async {
    final googleSingIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSingIn.signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final userCredential =
          await widget.auth.signInWithCredential(googleAuthCredential);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Sign In with ${userCredential.user!.displayName}")),
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 50,
                    child: FlutterLogo(
                      size: 60,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Hey There, \nWelcome Back",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Login to Your Account to Continue"),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: SignInButton(
                      Buttons.Email,
                      text: "Sign up with Email",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  EmailSignInScreen(auth: widget.auth)),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign up with Google",
                      onPressed: () {
                        _signInWithGoogle();
                      },
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
