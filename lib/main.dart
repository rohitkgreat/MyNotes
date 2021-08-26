import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:notess/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}


//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Noteit',

//       // theme: ThemeData(backgroundColor: Colors.white),
//       theme: ThemeData.dark().copyWith(
//           //  primaryColor: Colors.white,
//           //scaffoldBackgroundColor: Colors.white,
//           ),
//       home: LoginPage(),
//     );
//   }
// }
