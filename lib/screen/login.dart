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
  bool isLoading = false;
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
      setState(() {
        isLoading = true;
      });
      await Auth().signInWithEmailAndPassword(
          email: _idController.text, password: _passwordController.text);
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
                  obscureText: true,
                ),
                Gaps.v10,
                InkWell(
                  onTap: signInWithEamilAndPassword,
                  child: Container(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('마이타임 로그인'),
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
                TextButton(
                    onPressed: goSignupPage,
                    child: const Text(
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
