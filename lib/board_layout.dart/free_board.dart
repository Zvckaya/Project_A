import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/screen/add_post_screen.dart';
import 'package:project_a/widget/postcard.dart';

class FreeBoard extends StatefulWidget {
  const FreeBoard({super.key});

  @override
  State<FreeBoard> createState() => _FreeBoardState();
}

class _FreeBoardState extends State<FreeBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자유게시판'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, idx) {
          return PostCard(
            snap: 1,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.amber,
          );
        },
        itemCount: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AddPostScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        label: const Text('글쓰기'),
        icon: const Icon(Icons.edit),
        backgroundColor: Colors.grey.shade400,
      ),
    );
  }
}
