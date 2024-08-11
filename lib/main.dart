import 'package:flutter/material.dart';

import 'config/constants/environment.dart';

void main() async {
  await Environment.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(Environment.apiUrl),
        ),
      ),
    );
  }
}
