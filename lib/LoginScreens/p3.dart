// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:notess/pages/homepage.dart';

// class EmailVerifyScreen extends StatefulWidget {
//   const EmailVerifyScreen({Key? key, required this.auth}) : super(key: key);
//   final FirebaseAuth auth;

//   @override
//   _EmailVerifyScreenState createState() => _EmailVerifyScreenState();
// }

// class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
//   late User _user;
//   late Timer timer;

//   @override
//   void initState() {
//     _user = widget.auth.currentUser!;
//     _user.sendEmailVerification();
//     timer = Timer.periodic(
//       Duration(seconds: 15),
//       (timer) {
//         checkEmailVerified();
//       },
//     );
//     super.initState();
//   }

//   //pop()
//   //push()
//   //pushAndRemoveUntil()

//   Future<void> checkEmailVerified() async {
//     _user = widget.auth.currentUser!;
//     await _user.reload();
//     if (_user.emailVerified) {
//       timer.cancel();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => HomePage(auth: widget.auth),
//         ),
//         (route) => false,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Email Verification Screen"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             CircularProgressIndicator(),
//             Text("Please Wait Email (${_user.email} is Verifying!!"),
//           ],
//         ),
//       ),
//     );
//   }
// }
