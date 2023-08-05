import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_a/models/user.dart' as model;

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<model.User> getUserDetails() async {
    User currentUser = _firebaseAuth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    print(_firestore.collection('users').doc(currentUser.uid));
    print('데이터 실행');
    return model.User.fromStore(documentSnapshot);
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String studentId}) async {
    UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    model.User user = model.User(
        email: email,
        uid: cred.user!.uid,
        username: username,
        studentId: studentId);

    await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());
    print('유저생성완료');
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
