import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_a/constants/gaps.dart';
import 'package:project_a/firebase/firestore_method.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/models/user.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _onSubmitTap() {
    if (_formKey.currentContext != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
      }
      print(formDate['title']);
    }
  }

  void CreatePost(String uid, String username) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        formDate['title'].toString(),
        formDate['description'].toString(),
        uid,
        username,
      );
      if (res == "sucess") {
        setState(() {
          _isLoading = false;
        });
      } else {}
    } catch (e) {}
  }

  Map<String, String> formDate = {};
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _onSubmitTap();
              CreatePost(user!.uid, user!.username);
            },
            icon: Icon(
              Icons.check,
              color: Colors.cyan,
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Gaps.v24,
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '제목',
                    focusColor: Colors.cyan,
                    focusedBorder: InputBorder.none),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "제목을 작성하세요";
                  }
                  return null;
                },
                onSaved: (newVal) {
                  if (newVal != null) {
                    formDate['title'] = newVal;
                  }
                },
              ),
              Divider(
                color: Colors.white,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '내용',
                    focusColor: Colors.cyan,
                    focusedBorder: InputBorder.none),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "내용을 작성하세요";
                  }
                  return null;
                },
                onSaved: (newVal) {
                  if (newVal != null) {
                    formDate['description'] = newVal;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
