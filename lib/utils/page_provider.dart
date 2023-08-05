import 'package:flutter/cupertino.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/models/user.dart';

class PageProvider with ChangeNotifier {
  int _nowPage = 0;
  int get currentPage => _nowPage;

  selectPage(int index) {
    _nowPage = index;
    notifyListeners();
  }
}
