import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_a/board_layout.dart/free_board.dart';
import 'package:project_a/board_layout.dart/secret_board.dart';
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
import 'package:project_a/widget/todo_board.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum SiteUrl {
  home,
  notify,
  daily,
}

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.pageNumber,
    required this.goNext,
  });
  int pageNumber;
  VoidCallback? goNext;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageProvider _pageProvider;
  final FirebaseFirestore store = FirebaseFirestore.instance;

  Future<String> getLastestData(String post) async {
    String current_title = "데이터가 없습니다";
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await store.collection(post).get();
      if (querySnapshot.docs.isNotEmpty) {
        var lastestDocument = querySnapshot.docs;
        Map<String, dynamic> data = lastestDocument.last.data();
        current_title = data['title'];
      } else {
        print('가져오기 실패');
      }
    } catch (e) {}
    return current_title;
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  void _openURL(SiteUrl site) async {
    const home = 'https://www.skhu.ac.kr/sites/skhu/index.do';
    const notify = 'https://www.skhu.ac.kr/skhu/907/subview.do';
    const daily = 'https://www.skhu.ac.kr/skhu/802/subview.do';

    final url;
    if (site == SiteUrl.home) {
      url = home;
    } else if (site == SiteUrl.notify) {
      url = notify;
    } else {
      url = daily;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      SnackBar(
        content: Text('사이트를 열수 없습니다'),
      );
    }
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
              onPressed: () {
                widget.goNext;
              },
            ),
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
                  child: Today_news(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TodoList(),
                )
              ]),
            ),
          ),
          Gaps.v24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _openURL(SiteUrl.home);
                },
                child: custom_icon(
                  myicon: Icons.home,
                  mytext: '학교홈',
                ),
              ),
              Gaps.h10,
              InkWell(
                onTap: () {
                  _openURL(SiteUrl.notify);
                },
                child: custom_icon(
                  myicon: Icons.alarm,
                  mytext: '학사공지',
                ),
              ),
              Gaps.h10,
              InkWell(
                onTap: () {
                  _openURL(SiteUrl.daily);
                },
                child: custom_icon(
                  myicon: Icons.calendar_month,
                  mytext: '학사일정',
                ),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Gaps.v10,
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FreeBoard(),
                        ),
                      );
                    },
                    child: FutureBuilder(
                        future: getLastestData('posts'),
                        builder: (context, snapshot) {
                          return board_headline(
                            board_name: '자유게시판',
                            board_detail: snapshot.data,
                          );
                        }),
                  ),
                  Gaps.v10,
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SecretBoard(),
                        ),
                      );
                    },
                    child: FutureBuilder(
                        future: getLastestData('sec_posts'),
                        builder: (context, snapshot) {
                          return board_headline(
                            board_name: '비밀게시판',
                            board_detail: snapshot.data,
                          );
                        }),
                  ),
                  Gaps.v10,
                  board_headline(
                    board_name: '장터게시판',
                    board_detail: '전공책 팝니다',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
