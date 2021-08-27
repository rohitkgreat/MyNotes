import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notess/LoginScreens/FirstScreen.dart';
import 'package:notess/controller/google_auth.dart';
import 'package:notess/pages/addnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notess/pages/view.dart';

import 'package:notess/pages/editing.dart';

bool check = false;

class HomePage extends StatefulWidget {
  final FirebaseAuth auth;
  HomePage({required this.auth});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'MyNotes',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    await widget.auth.signOut();
                    await googleSignIn.signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LandingScreen()));
                  },
                  child: Row(
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => Padding(
              padding:
                  const EdgeInsets.only(top: 15, bottom: 15, right: 5, left: 5),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300),
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          toolbarHeight: 80,
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300),
                //  color: Colors.redAccent,
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.search,
                      size: 25,
                    )),
              ),
            ),
          ],
          centerTitle: true,
          title: Text(
            'MyNotes',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Addnote()),
            );
          },
          backgroundColor: Colors.blue.shade900,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: ref.orderBy('time', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length == 0)
                return Center(
                  child: Text(
                    "No Notes to display for now!",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                );

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // final snapshot1 = snapshot.data!.docs.reversed;
                  Map<dynamic, dynamic>? data =
                      snapshot.data!.docs[index].data() as Map?;
                  DateTime mydate = data!['time'].toDate();
                  String time = DateFormat.yMMMd().add_jm().format(mydate);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Edit(
                              data: data,
                              time: time,
                              ref: snapshot.data!.docs[index].reference)));
                    },
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                          // color: Colors.blueAccent,
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.5, color: Colors.grey.shade600))),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "${data['title']}",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  PopupMenuButton(
                                    icon: Icon(Icons.more_vert_outlined),
                                    itemBuilder: (context) {
                                      return List.generate(1, (index) {
                                        return PopupMenuItem(
                                          child: TextButton(
                                            child: Text('Edit'),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Viewnote(
                                                            data: data,
                                                            time: time,
                                                            ref: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .reference)),
                                              );
                                            },
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  "${data['description']}",
                                  maxLines: 2,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat.yMMMd().add_jm().format(mydate),
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
