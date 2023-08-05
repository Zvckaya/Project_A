import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/constants/sizes.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/screen/mypage.dart';
import 'package:project_a/utils/page_provider.dart';
import 'package:project_a/widget/cupButton.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);

    await userProvider.refreshUser();
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '마이타임',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 12),
            ),
            Text(
              '성공회대',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                icon: Icon(Icons.perm_identity),
                onPressed: context.read<PageProvider>().selectPage(2)),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 78, 78),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 101, 101, 101))),
                    width: 300,
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '오늘의 소식 💡',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text('학사일정'),
                            backgroundColor: Colors.black26,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
          Gaps.v44,
          CupertinoButton(
            child: Text('로그아웃'),
            color: Colors.cyan,
            onPressed: signOut,
          )
        ],
      ),
    );
  }
}
