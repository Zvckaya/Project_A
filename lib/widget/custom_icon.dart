import 'package:flutter/cupertino.dart';

class custom_icon extends StatelessWidget {
  custom_icon({super.key, required this.myicon, required this.mytext});
  IconData myicon;
  String mytext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 78, 78, 78),
          ),
          child: Icon(myicon),
        ),
        Text(mytext)
      ],
    );
  }
}
