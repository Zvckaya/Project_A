import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cupButton(String text, VoidCallback? fc) {
  return CupertinoButton(
    color: Colors.cyan,
    child: Text(text),
    onPressed: fc,
  );
}
