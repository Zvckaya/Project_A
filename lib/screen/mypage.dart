import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart' as model;
import 'package:project_a/screen/login.dart';
import 'package:project_a/utils/page_provider.dart';
import 'package:project_a/widget/cupButton.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  MyPage({super.key, required this.pageNumber});
  int pageNumber;

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    PageProvider pageProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 정보',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          Gaps.v32,
          Container(
            child: Text('어서오세요 ${user?.username}님'),
          ),
          Gaps.v10,
          CupertinoButton(
            child: Text('로그아웃'),
            color: Theme.of(context).primaryColor,
            onPressed: signOut,
          )
        ]),
      ),
    );
  }
}
