import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart' as model;
import 'package:project_a/screen/home.dart';
import 'package:project_a/screen/mypage.dart';
import 'package:project_a/utils/dimesions.dart';
import 'package:project_a/utils/page_provider.dart';
import 'package:provider/provider.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({super.key});

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  late PageController pageController;
  int currentPage = 0;
  late PageProvider pageProvider;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    pageProvider = Provider.of<PageProvider>(context, listen: false);

    addDate();
    super.initState();
  }

  addDate() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  goMyPage() {
    pageProvider.goToPage(1);
    print('실행');
  }

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;

    return user == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : Scaffold(
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(
                  pageNumber: 1,
                  goNext: goMyPage,
                ),
                MyPage(
                  pageNumber: 2,
                ),
              ],
              controller: pageController,
            ),
          );
  }
}
