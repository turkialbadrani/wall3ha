
import 'dart:convert';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class WhatsGroupFileLoader extends StatefulWidget {
  final Function(String rawText) onParsed;

  const WhatsGroupFileLoader({required this.onParsed, Key? key}) : super(key: key);

  @override
  State<WhatsGroupFileLoader> createState() => _WhatsGroupFileLoaderState();
}

class _WhatsGroupFileLoaderState extends State<WhatsGroupFileLoader> {
  String? error;

  Future<void> _pickAndParseFile() async {
    setState(() => error = null);

    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['txt', 'zip']);
    if (result == null || result.files.isEmpty) return;

    final file = File(result.files.first.path!);

    try {
      String? chatText;

      if (file.path.endsWith('.zip')) {
        final inputStream = InputFileStream(file.path);
        final archive = ZipDecoder().decodeBuffer(inputStream);

        final chatEntry = archive.files.firstWhere(
          (f) => f.name.endsWith('_chat.txt'),
          orElse: () => throw Exception('ما وجدنا ملف ينتهي بـ _chat.txt داخل الضغط.'),
        );

        chatText = utf8.decode(chatEntry.content);
      } else if (file.path.endsWith('.txt')) {
        chatText = await file.readAsString();
      }

      if (chatText != null) {
        widget.onParsed(chatText);
      } else {
        setState(() => error = "الملف غير مدعوم.");
      }
    } catch (e) {
      setState(() => error = "صار خطأ أثناء تحليل الملف: \$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _pickAndParseFile,
          icon: Icon(Icons.upload_file),
          label: Text("تحميل ملف المحادثة"),
        ),
        if (error != null) Text(error!, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
