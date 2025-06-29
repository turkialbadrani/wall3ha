
import 'package:flutter/material.dart';

class GeneratedMessageBoxWidget extends StatelessWidget {
  final String message;

  const GeneratedMessageBoxWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(message, style: const TextStyle(color: Colors.white)),
    );
  }
}
