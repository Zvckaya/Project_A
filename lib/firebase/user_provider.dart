import 'package:flutter/cupertino.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Auth _auth = Auth();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
