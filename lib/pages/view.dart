import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'editing.dart';

bool _star = false;

class Edit extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;
  const Edit(
      {Key? key, required this.data, required this.time, required this.ref})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 40,
                  width: 40,
                  //  color: Colors.lightGreen,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color(0xffC9CCD5),
                      color: Colors.blue.shade100),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                  ),
                ),
              ),
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  width: double.infinity,
                  height: 600,
                  //color: Color(0xffC9CCD5),
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data['title']}',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Text(
                          '${widget.data['description']}',
                          style: TextStyle(height: 1.5, fontSize: 15),
                          softWrap: true,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text('${widget.time}'),
                            Spacer(),
                            Icon(
                              Icons.photo_album,
                              color: Colors.black45,
                            ),
                            Icon(
                              Icons.mic,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Viewnote(
                                              data: widget.data,
                                              time: widget.time,
                                              ref: widget.ref)));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 31,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _star = !_star;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: _star ? Colors.yellow : Colors.black54,
                                  size: 31,
                                )),
                            IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.share,
                                  size: 31,
                                )),
                            IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.more_vert_outlined,
                                  size: 31,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
