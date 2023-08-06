import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/constants/sizes.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/screen/mypage.dart';
import 'package:project_a/utils/page_provider.dart';
import 'package:project_a/widget/board_headline.dart';
import 'package:project_a/widget/cupButton.dart';
import 'package:project_a/widget/custom_icon.dart';
import 'package:project_a/widget/today_news.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageProvider _pageProvider;

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

  changePage() {
    _pageProvider.selectPage(2);
  }

  @override
  Widget build(BuildContext context) {
    _pageProvider = Provider.of<PageProvider>(context, listen: false);
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
                onPressed: changePage,
              ))
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
                  child: Today_news(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 78, 78, 78),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromARGB(255, 101, 101, 101),
                      ),
                    ),
                    child: Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "오늘의 할일 ☑️",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          Chip(
                            label: Text('추가 ➕'),
                            backgroundColor: Colors.black26,
                          )
                        ],
                      )
                    ]),
                  ),
                )
              ]),
            ),
          ),
          Gaps.v24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              custom_icon(
                myicon: Icons.home,
                mytext: '학교홈',
              ),
              Gaps.h10,
              custom_icon(
                myicon: Icons.alarm,
                mytext: '학사공지',
              ),
              Gaps.h10,
              custom_icon(
                myicon: Icons.calendar_month,
                mytext: '학사일정',
              )
            ],
          ),
          Gaps.v20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 78, 78),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 101, 101, 101),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '게시판',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Gaps.v10,
                    board_headline(
                      board_name: '자유게시판',
                      board_detail: '수강신청 성공하는법',
                    ),
                    Gaps.v10,
                    board_headline(
                      board_name: '비밀게시판',
                      board_detail: '내가 고민이 있다.',
                    ),
                    Gaps.v10,
                    board_headline(
                      board_name: '장터게시판',
                      board_detail: '전공책 팝니다',
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
