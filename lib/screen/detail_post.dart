import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/firestore_method.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart';
import 'package:project_a/widget/comments.dart';
import 'package:provider/provider.dart';

class DetailPost extends StatefulWidget {
  DetailPost(
      {super.key,
      required this.snap,
      required this.user,
      required this.boardtype});
  final snap;
  String boardtype;
  User user;
  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  final TextEditingController commetController = TextEditingController();
  bool? isChecked = true;

  void postComment(String postId, String uid, String username, String boardtype,
      bool anonymous) async {
    try {
      String res = await FirestoreMethods().postComment(
          postId, commetController.text, uid, username, boardtype, anonymous);
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

  deletePost(String postId, String board_type) async {
    try {
      await FirestoreMethods().deletePost(postId, board_type);
      Navigator.of(context).pop();
    } catch (err) {
      SnackBar(
        content: Text(err.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.boardtype == "posts" ? '자유' : '비밀'}게시판'),
        actions: [
          widget.snap['uid'].toString() == user!.uid
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: ['Delete']
                                  .map((e) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                      onTap: () {
                                        deletePost(
                                            widget.snap['postId'].toString(),
                                            widget.boardtype);
                                      }))
                                  .toList(),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.more_vert),
                )
              : IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
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
            Gaps.v10,
            Expanded(
              child: Comments(
                  postId: widget.snap['postId'].toString(),
                  board_type:
                      widget.boardtype == 'free' ? 'posts' : 'sec_posts'),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 100,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: EdgeInsets.only(
          bottom: 40,
        ),
        child: Row(
          children: [
            Checkbox(
                value: isChecked,
                onChanged: (val) {
                  setState(() {
                    isChecked = val;
                  });
                }),
            Text('익명'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: commetController,
                  decoration: InputDecoration(
                    hintText: '댓글을 작성하세요.',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                String board_t;
                if (widget.boardtype == 'free') {
                  board_t = 'posts';
                } else {
                  board_t = 'sec_posts';
                }
                postComment(widget.snap['postId'], user!.uid, user.username,
                    board_t, isChecked!);
              },
              icon: Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
