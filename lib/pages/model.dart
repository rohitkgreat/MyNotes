import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference ref = _firestore
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('notes');

class Databasee {
  static create(Map<String, dynamic> data) {
    ref.add(data);
  }

  static Future<QuerySnapshot> read() async {
    QuerySnapshot querySnapshot = await ref.get();
    return querySnapshot;
  }

  static Stream<QuerySnapshot> read2() {
    final stream = ref.snapshots();
    return stream;
  }

  static update(Map<String, dynamic> data) {
    ref.doc().update(data);
  }

  static delete(String docid) {
    ref.doc(docid).delete();
  }
}
