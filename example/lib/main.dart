import 'package:easy_connect/easy_connect.dart';
import 'package:flutter/material.dart';

void main() {
  // set easy_connect config
  setEasyConnectConfig(EasyConnectConfig(
    url: "https://google.com",
    timeout: const Duration(seconds: 10),
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
