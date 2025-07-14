import 'package:flutter/material.dart';
import 'package:flutter_protect_runtime/flutter_protect_runtime.dart';

void main() {
  initGuard();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Runtime Guard Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const Scaffold(
        body: Center(
          child: Text('🔐 正在保护中...\n请查看控制台输出', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
