import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

String desc = "";
String text = "";

class Viewnote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  Viewnote({required this.data, required this.time, required this.ref});
  @override
  _ViewnoteState createState() => _ViewnoteState();
}

class _ViewnoteState extends State<Viewnote> {
  @override
  void initState() {
    text = '${widget.data['title']}';
    desc = '${widget.data['description']}';
    super.initState();
  }

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
                      onPressed: save,
                      child: Text('Save'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: '${widget.data['title']}',
                        style: TextStyle(
                            color: Colors.red.shade400,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600),
                        onChanged: (value) {
                          text = value;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: TextFormField(
                          initialValue: '${widget.data['description']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600),
                          maxLines: 20,
                          onChanged: (value) {
                            desc = value;
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dlt() async {
    Navigator.of(context).pop();
  }

  void save() async {
    try {
      await widget.ref.update({
        'title': text,
        'description': desc,
        'time': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pop();
  }
}
