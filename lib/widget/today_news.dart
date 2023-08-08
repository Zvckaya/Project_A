import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Today_news extends StatelessWidget {
  const Today_news({
    super.key,
  });

  _openURL() async {
    const url = 'https://www.skhu.ac.kr/skhu/802/subview.do';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw '사이트를 열 수 없습니다';
    }
  }

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
            InkWell(
              onTap: _openURL,
              child: Chip(
                label: Text('학사일정'),
                backgroundColor: Colors.black26,
              ),
            )
          ],
        ),
      ),
    );
  }
}
