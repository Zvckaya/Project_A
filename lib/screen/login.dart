import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/constants/sizes.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/screen/home.dart';
import 'package:project_a/screen/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;
  late TextEditingController _idController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signInWithEamilAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _idController.text, password: _passwordController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void goSignupPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size64),
            child: Column(
              children: [
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                Column(
                  children: [
                    Text("대학 생활을 더 편하고 즐겁게"),
                    Text(
                      "마이 타임",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ],
                ),
                Gaps.v10,
                CupertinoTextField.borderless(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 109, 109, 109),
                      borderRadius: BorderRadius.circular(10)),
                  controller: _idController,
                  placeholder: '아이디',
                ),
                Gaps.v10,
                CupertinoTextField.borderless(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 109, 109, 109),
                      borderRadius: BorderRadius.circular(10)),
                  controller: _passwordController,
                  placeholder: '비밀번호',
                ),
                Gaps.v10,
                Container(
                  width: double.infinity,
                  height: 35,
                  child: CupertinoButton(
                    child: Text('마이타임 로그인'),
                    minSize: 0.0,
                    padding: EdgeInsets.all(0),
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: signInWithEamilAndPassword,
                  ),
                ),
                TextButton(
                    onPressed: goSignupPage,
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                Flexible(
                  child: Container(),
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
