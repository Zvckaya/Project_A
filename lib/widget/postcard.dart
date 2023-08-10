import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/firestore_method.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart';
import 'package:project_a/screen/detail_post.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  String boardtype;
  PostCard({super.key, required this.snap, required this.boardtype});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String getPostday(Timestamp post) {
    DateTime date = DateTime.parse(post.toDate().toString());
    DateFormat formatter = DateFormat('M월 dd일');
    String strToday = formatter.format(date);
    return strToday;
  }

  void goDetailPost(final snap, User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPost(
          snap: snap,
          user: user,
          boardtype: widget.boardtype,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    return InkWell(
      onTap: () {
        goDetailPost(widget.snap, user!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.snap['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.snap['description'],
              style: TextStyle(fontSize: 18, color: Colors.grey.shade200),
            ),
            Expanded(child: SizedBox()),
            Row(
              children: [
                widget.snap['like'].isEmpty
                    ? Text('')
                    : Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 20,
                          ),
                          Text(' ${widget.snap['like'].length}'),
                        ],
                      ),
                VerticalDivider(),
                Text(
                  FirestoreMethods.getPostday(widget.snap['datePublished']),
                  style: TextStyle(color: Colors.grey),
                ),
                VerticalDivider(
                  color: Colors.white,
                ),
                Text(widget.snap['anonymous'] ? '익명' : widget.snap['username']),
              ],
            )
          ],
        ),
      ),
    );
  }
}
