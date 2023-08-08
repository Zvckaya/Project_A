import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/firestore_method.dart';
import 'package:project_a/models/user.dart';

class DetailPost extends StatefulWidget {
  DetailPost({super.key, required this.snap, required this.user});
  final snap;
  User user;
  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  @override
  Widget build(BuildContext context) {
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
                Text('${widget.snap['like'].length}')
              ],
            )
          ],
        ),
      ),
    );
  }
}
