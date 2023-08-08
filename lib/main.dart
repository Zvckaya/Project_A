import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/page_selector.dart';
import 'package:project_a/screen/add_post_screen.dart';
import 'package:project_a/screen/login.dart';
import 'package:project_a/utils/page_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (cnt) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (cnt) => PageProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mytime',
        theme: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(
              elevation: 0,
              color: Colors.grey.shade900,
            ),
            primaryColor: Colors.cyan,
            cupertinoOverrideTheme: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            scaffoldBackgroundColor: Colors.grey.shade900),
        home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return PageSelector();
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              );
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
