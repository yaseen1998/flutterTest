import 'package:citycafe_app/screens/login_screen.dart';
import 'package:citycafe_app/screens/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Start();
  }
}
