import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '익명1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('우리는 틀리지 않았다...')
        ],
      ),
    );
  }
}
