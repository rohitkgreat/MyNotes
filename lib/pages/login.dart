import 'package:flutter/material.dart';
import 'package:notess/controller/google_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            check == true
                ? Center(child: CircularProgressIndicator())
                : AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText('Notess App',
                          speed: Duration(milliseconds: 100),
                          textStyle: TextStyle(
                              fontSize: 50, color: Colors.blueAccent.shade700)),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/note.png'),
                  ),
                ),
              ),
            ),
            Text(
              "Let's create and manage your notes ",
              style: TextStyle(color: Colors.purple.shade900),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 80, top: 10),
              child: ElevatedButton(
                onPressed: () {
                  check = true;
                  signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue with Google',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(
                      width: 60,
                      height: 42,
                      child: Image.asset(
                        'assets/ggl.png',
                        height: 32,
                      ),
                    )
                  ],
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
