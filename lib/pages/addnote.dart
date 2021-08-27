import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  String desc = "";
  String text = "";
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15))))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))))),
                      onPressed: add,
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 24),
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
    if (text.isEmpty || desc.isEmpty) {
      SnackBar snackBar = SnackBar(content: Text('One or both field is Empty'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
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
    }
    text = "";
    desc = "";
    // Databasee.create(data);
    Navigator.pop(context);
  }
}
