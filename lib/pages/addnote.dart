import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

String desc = "";
String text = "";

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    ElevatedButton(
                      onPressed: add,
                      child: Text('Save'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration.collapsed(hintText: 'Title'),
                      style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600),
                      onChanged: (val) {
                        text = val;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'Write here'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600),
                        onChanged: (val) {
                          desc = val;
                        },
                        maxLines: 20,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference ref = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');
    var data = {
      'title': text,
      'description': desc,
      'time': DateTime.now(),
    };

    ref.add(data);

    // Databasee.create(data);
    Navigator.pop(context);
  }
}
