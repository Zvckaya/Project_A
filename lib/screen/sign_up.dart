import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/constants/sizes.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/screen/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpPage> {
  String? errorMessage = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sidController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _sidController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void goLoginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          studentId: _sidController.text);

      goLoginPage();
    } on FirebaseException catch (e) {
      setState(() {
        _isLoading = false;
        errorMessage = e.message;
      });
      const SnackBar(
        content: Text('회원가입에 실패하였습니다'),
      );
    }
  }

  // Widget _errorMessage() {
  //   return Text(errorMessage == '' ? '' : '에러발생 $errorMessage');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Column(
              children: [
                const Text("대학 생활을 더 편하고 즐겁게"),
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
            Gaps.v24,
            CupertinoTextField.borderless(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 109, 109, 109),
                  borderRadius: BorderRadius.circular(10)),
              placeholder: "닉네임을 입력하세요",
              keyboardType: TextInputType.emailAddress,
              controller: _usernameController,
            ),
            Gaps.v24,
            CupertinoTextField.borderless(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 109, 109, 109),
                  borderRadius: BorderRadius.circular(10)),
              placeholder: '이메일을 입력하세요',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            Gaps.v24,
            CupertinoTextField.borderless(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 109, 109, 109),
                  borderRadius: BorderRadius.circular(10)),
              placeholder: '비밀번호를 입력하세요',
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText: true,
            ),
            Gaps.v24,
            CupertinoTextField.borderless(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 109, 109, 109),
                  borderRadius: BorderRadius.circular(10)),
              placeholder: '학번을 입력하세요',
              keyboardType: TextInputType.text,
              controller: _sidController,
            ),
            Gaps.v24,
            InkWell(
              onTap: createUserWithEmailAndPassword,
              child: Container(
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text('회원가입'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: Sizes.size12),
                decoration: const ShapeDecoration(
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v12,
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("이미 아이디가 있나요?"),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: goLoginPage,
                  child: Container(
                    child: Text(
                      "로그인.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
