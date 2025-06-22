
import 'package:flutter/material.dart';
import 'quick_reply.dart';

void main() {
  runApp(const Wall3haApp());
}

class Wall3haApp extends StatelessWidget {
  const Wall3haApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ولّعها',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const QuickReplyPage(),
    );
  }
}
