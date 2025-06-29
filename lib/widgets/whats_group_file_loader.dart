
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class WhatsGroupFileLoader extends StatefulWidget {
  final void Function({
    required Map<String, List<String>> messagesByUser,
    required List<Map<String, dynamic>> parsedMessages,
  }) onParsed;

  const WhatsGroupFileLoader({Key? key, required this.onParsed}) : super(key: key);

  @override
  State<WhatsGroupFileLoader> createState() => _WhatsGroupFileLoaderState();
}

class _WhatsGroupFileLoaderState extends State<WhatsGroupFileLoader> {
  bool isLoading = false;
  String? error;

  Future<void> pickFileAndParse() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final lines = await File(filePath).readAsLines();

        Map<String, List<String>> messagesByUser = {};
        List<Map<String, dynamic>> parsedMessages = [];

        for (var line in lines) {
          final match = RegExp(r'^(\d{1,2}/\d{1,2}/\d{2,4})[, ]+(\d{1,2}:\d{2}) ?(?:[APMapm]+|ص|م|صباحاً|مساءً)? ?- ([^:]+): (.+)').firstMatch(line);
          if (match != null) {
            final name = match.group(3)?.trim() ?? 'غير معروف';
            final msg = match.group(4)?.trim() ?? '';
            parsedMessages.add({'name': name, 'text': msg});
            messagesByUser.putIfAbsent(name, () => []).add(msg);
          }
        }

        if (parsedMessages.isEmpty) {
          setState(() => error = 'ما قدرنا نحلل أي رسائل من الملف');
        } else {
          widget.onParsed(
            messagesByUser: messagesByUser,
            parsedMessages: parsedMessages,
          );
        }
      } else {
        setState(() => error = 'لم يتم اختيار أي ملف');
      }
    } catch (e) {
      setState(() => error = 'حدث خطأ: \$e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: isLoading ? null : pickFileAndParse,
          icon: const Icon(Icons.upload_file),
          label: const Text("📁 ارفع ملف القروب (.txt)"),
        ),
        const SizedBox(height: 12),
        if (isLoading) const CircularProgressIndicator(),
        if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
      ],
    );
  }
}
