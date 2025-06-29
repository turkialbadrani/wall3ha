
import 'package:flutter/material.dart';

class InputFieldSectionWidget extends StatelessWidget {
  final TextEditingController controller;

  const InputFieldSectionWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: '...اكتب هنا أي شيء تبي رد عليه أو تغريدة عنه',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
