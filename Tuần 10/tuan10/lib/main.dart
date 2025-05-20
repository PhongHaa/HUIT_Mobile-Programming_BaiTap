import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuan 10 Menu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeMenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
