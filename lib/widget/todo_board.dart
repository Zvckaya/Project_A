import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('M월-dd일(E)');
  String strToday = formatter.format(now);
  return strToday;
}

Container TodoList() {
  return Container(
    padding: EdgeInsets.all(20),
    width: 300,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 78, 78, 78),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color.fromARGB(255, 101, 101, 101),
      ),
    ),
    child: Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "오늘의 할일 ☑️",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(getToday(), style: TextStyle(color: Colors.blueAccent)),
            ],
          ),
          Chip(
            label: Text('추가 ➕'),
            backgroundColor: Colors.black26,
          )
        ],
      )
    ]),
  );
}
