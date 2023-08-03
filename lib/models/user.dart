import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String studentId;
  final String email;

  User({
    required this.email,
    required this.uid,
    required this.username,
    required this.studentId,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'studentId': studentId
      };

  static User fromStore(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return User(
        email: data['email'],
        uid: data['uid'],
        username: data['username'],
        studentId: data['studentId']);
  }
}
