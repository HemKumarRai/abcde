import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DataBaseMethods with ChangeNotifier {
  addUserInfo(userMap) async {
    await Firestore.instance.collection('users').add(userMap);
  }

  addComment(String id, commentMap) async {
    return Firestore.instance
        .collection('commentRoom')
        .document(id)
        .collection('comments')
        .add(commentMap);
    print('NEpal');
  }

  Future getComment(String id) async {
    return Firestore.instance
        .collection('commentRoom')
        .document(id)
        .collection('comments')
        .orderBy('time', descending: false)
        .snapshots();
  }

  getCurrentUser() {
    return FirebaseAuth.instance.currentUser;

//    return Firestore.instance.collection('users').getDocuments();
  }
}
