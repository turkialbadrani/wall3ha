import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  const MessageInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(fontFamily: 'Cairo', color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.mail_outline, color: Colors.white70),
          hintText: '✉️ اكتب الرسالة المستلمة هنا...',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}

class EventInput extends StatelessWidget {
  final TextEditingController controller;
  const EventInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(fontFamily: 'Cairo', color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.celebration, color: Colors.white70),
          hintText: '🎉 اكتب المناسبة أو الحدث...',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}

class HashtagInput extends StatelessWidget {
  final TextEditingController controller;
  const HashtagInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(fontFamily: 'Cairo', color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.tag, color: Colors.white70),
          hintText: '🏷️ اكتب الهاشتاق...',
          hintStyle: TextStyle(color: Colors.white54, fontFamily: 'Cairo'),
        ),
      ),
    );
  }
}
