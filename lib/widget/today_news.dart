import 'package:flutter/material.dart';

class Today_news extends StatelessWidget {
  const Today_news({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 78, 78, 78),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 101, 101, 101))),
      width: 300,
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '오늘의 소식 💡',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Chip(
              label: Text('학사일정'),
              backgroundColor: Colors.black26,
            )
          ],
        ),
      ),
    );
  }
}
