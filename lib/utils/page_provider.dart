import 'package:flutter/cupertino.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/models/user.dart';

class PageProvider with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void goToPage(int page) {
    if (_currentPage != page) {
      _currentPage = page;
      notifyListeners();
    }
  }
}
