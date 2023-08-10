import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snap['anonymous'] ? '익명' : snap['username'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(snap['text'])
        ],
      ),
    );
  }
}
