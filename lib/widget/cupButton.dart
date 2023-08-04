import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cupButton(String text, VoidCallback? fc) {
  return CupertinoButton(
    child: Text(text),
    onPressed: fc,
  );
}
