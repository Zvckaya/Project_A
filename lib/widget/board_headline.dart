import 'package:flutter/cupertino.dart';
import 'package:project_a/constants/gaps.dart';

class board_headline extends StatelessWidget {
  final String board_name;
  final String? board_detail;
  const board_headline({
    required this.board_name,
    required this.board_detail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          board_name!,
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        Gaps.h10,
        Text(
          board_detail ?? '내용이 없습니다.',
          style: TextStyle(color: const Color.fromARGB(255, 202, 202, 202)),
        )
      ],
    );
  }
}
