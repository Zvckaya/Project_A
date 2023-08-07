import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_a/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String title, String description, String uid, String username) async {
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
      );
      await _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
