import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '컴퓨터공학 수강바구니',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Gaps.v10,
          Text(
            '신청어캐하는지 아는사람?',
            style: TextStyle(color: Colors.grey.shade400),
          )
        ],
      ),
    );
  }
}
