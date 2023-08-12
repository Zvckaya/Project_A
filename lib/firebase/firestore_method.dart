import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:project_a/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String title, String description, String uid,
      String username, bool anonymous) async {
    String res = "";
    try {
      String postId = const Uuid().v1();
      Post post = Post(
        title: title,
        description: description,
        uid: uid,
        username: username,
        like: [],
        postId: postId,
        datePublished: DateTime.now(),
        anonymous: anonymous,
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadSecPost(String title, String description, String uid,
      String username, bool anonymous) async {
    String res = "";
    try {
      String postId = const Uuid().v1();
      Post post = Post(
          title: title,
          description: description,
          uid: uid,
          username: username,
          like: [],
          postId: postId,
          datePublished: DateTime.now(),
          anonymous: anonymous);
      await _firestore.collection('sec_posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> postComment(String postId, String text, String uid,
      String username, String boardtype, bool anonymous) async {
    String res = "오류발생";
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection(boardtype)
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'username': username,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
          'anonymous': anonymous
        });
        res = 'successs';
      } else {
        res = '글자를 입력하세요';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> deletePost(String postId, String board_type) async {
    String res = "오류발생";
    try {
      await _firestore.collection(board_type).doc(postId).delete();
      res = 'succes';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  static String getPostday(Timestamp post) {
    DateTime date = DateTime.parse(post.toDate().toString());
    DateFormat formatter = DateFormat('M월 dd일');
    String strToday = formatter.format(date);
    return strToday;
  }

  static String getPostdayDetail(Timestamp post) {
    DateTime date = DateTime.parse(post.toDate().toString());
    DateFormat formatter = DateFormat('MM/dd hh:ss');
    String strToday = formatter.format(date);
    return strToday;
  }
}
