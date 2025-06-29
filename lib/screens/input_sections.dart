
import 'package:flutter/material.dart';

Widget buildTypeSelector() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        '✍️ اكتب الرسالة أو المناسبة أو الهاشتاق داخل النص، و"ولّعها" بتفهمك.',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
        textAlign: TextAlign.right,
      ),
      SizedBox(height: 10),
    ],
  );
}

Widget buildInputFields(String selectedType, TextEditingController messageController,
    TextEditingController eventController, TextEditingController hashtagController) {
  return TextField(
    controller: messageController,
    maxLines: 5,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.black26,
      hintText: 'اكتب هنا أي شيء تبي رد عليه أو تغريدة عنه...',
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}
