import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/firestore_method.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart';
import 'package:project_a/widget/comments.dart';
import 'package:provider/provider.dart';

class DetailPost extends StatefulWidget {
  DetailPost({super.key, required this.snap, required this.user});
  final snap;
  User user;
  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  final TextEditingController commetController = TextEditingController();

  void postComment(
      String postId, String uid, String username, String boardtype) async {
    try {
      String res = await FirestoreMethods().postComment(
        postId,
        commetController.text,
        uid,
        username,
        boardtype,
      );
      if (res != 'success') {
        if (context.mounted)
          SnackBar(
            content: Text(res.toString()),
          );
      }
      setState(() {
        commetController.text = "";
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('자유게시판'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.snap['anonymous'] ? '익명' : widget.snap['username'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              FirestoreMethods.getPostdayDetail(
                widget.snap['datePublished'],
              ),
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            Gaps.v10,
            Text(
              widget.snap['title'],
              style: TextStyle(fontSize: 18),
            ),
            Gaps.v10,
            Text(widget.snap['description']),
            Gaps.v10,
            Row(
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                  size: 20,
                ),
                Text(
                  '${widget.snap['like'].length}',
                ),
                Gaps.h11,
                Icon(
                  Icons.message,
                  size: 20,
                ),
                Text('0')
              ],
            ),
            Expanded(
              child: Comments(
                  postId: widget.snap['postId'].toString(),
                  board_type: 'posts'),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: commetController,
                    decoration: InputDecoration(
                        hintText: '${user!.username}님으로 글 작성',
                        border: InputBorder.none),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
