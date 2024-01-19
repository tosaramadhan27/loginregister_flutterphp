import 'package:flutter/material.dart';
import 'package:login_register/dashboard.dart';
import 'package:login_register/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Login(),
    );
  }
}
