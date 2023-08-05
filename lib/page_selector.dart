import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart' as model;
import 'package:project_a/utils/dimesions.dart';
import 'package:provider/provider.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({super.key});

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void changePage() {}

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return user == null
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          ))
        : Scaffold(
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              children: homeScreen,
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
          );
  }
}
