import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/firebase/auth.dart';
import 'package:project_a/firebase/user_provider.dart';
import 'package:project_a/screen/home.dart';
import 'package:project_a/screen/login.dart';
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
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mytime',
        theme: ThemeData.dark().copyWith(primaryColor: Colors.cyan),
        home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomePage();
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
