import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/firestore_method.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart';
import 'package:project_a/widget/comment_card.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  Comments({
    super.key,
    required this.postId,
    required this.board_type,
  });
  final postId;
  String board_type;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(widget.board_type)
          .doc(widget.postId)
          .collection('comments')
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.separated(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => CommentCard(
            snap: snapshot.data!.docs[index],
          ),
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
      },
    );
  }
}
