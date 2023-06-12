import 'package:flutter/material.dart';
import 'users/login.dart';
import 'departements/dep.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'pfe',
      home: DepInfo(),
    );
  }
}
