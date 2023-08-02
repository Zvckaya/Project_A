import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/screen/home.dart';
import 'package:project_a/screen/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mytime',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.cyan),
      home: LoginPage(),
    );
  }
}
