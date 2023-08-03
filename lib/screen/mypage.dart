import 'package:flutter/material.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart' as model;
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
      body: Column(children: [
        Container(
          child: Text('어서오세요 ${user?.username}님'),
        )
      ]),
    );
  }
}
