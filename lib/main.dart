import 'package:authentication/authentication/sign_up_srcreen.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AuthenticationApp());
}

class AuthenticationApp extends StatelessWidget {
  const AuthenticationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authenticaiton UI',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white),
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size36,
            fontWeight: FontWeight.w800,
          ),
        ),
        primaryColor: const Color(0xFF1DA1F2),
      ),
      home: const SignUpSrcreen(),
    );
  }
}
