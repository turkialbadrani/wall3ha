
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class WhatsGroupScreen extends StatefulWidget {
  const WhatsGroupScreen({Key? key}) : super(key: key);

  @override
  State<WhatsGroupScreen> createState() => _WhatsGroupScreenState();
}

class _WhatsGroupScreenState extends State<WhatsGroupScreen> {
  List<String> parsedMessages = [];
  Map<String, List<String>> messagesByUser = {};
  String? error;
  String? debugMessage;

  void handleParsedText(String rawText) {
    List<String> allLines = parseWhatsappText(rawText);
    final messages = allLines.length > 1000 ? allLines.take(1000).toList() : allLines;
    final grouped = groupMessagesByUser(messages);

    print('✅ عدد الرسائل: ${messages.length}');
    print('👥 عدد الأعضاء: ${grouped.length}');

    setState(() {
      parsedMessages = messages;
      messagesByUser = grouped;
      debugMessage = 'تم التحليل: ${messages.length} رسالة';
    });
  }

  List<String> parseWhatsappText(String rawText) {
    return rawText.split('\n').where((line) => line.trim().isNotEmpty).toList();
  }

  Map<String, List<String>> groupMessagesByUser(List<String> messages) {
    final map = <String, List<String>>{};
    for (final line in messages) {
      final closingBracketIndex = line.indexOf(']');
      if (closingBracketIndex == -1) continue;

      final remainder = line.substring(closingBracketIndex + 1).trim();
      final colonIndex = remainder.indexOf(':');
      if (colonIndex == -1) continue;

      final user = remainder.substring(0, colonIndex).trim();
      final message = remainder.substring(colonIndex + 1).trim();

      map.putIfAbsent(user, () => []).add(message);
    }
    return map;
  }

  Future<void> _pickAndParseFile() async {
    setState(() {
      error = null;
      debugMessage = null;
    });

    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['txt', 'zip']);
    if (result == null || result.files.isEmpty) return;

    final platformFile = result.files.first;
    final bytes = platformFile.bytes;
    if (bytes == null) {
      setState(() => error = "تعذر قراءة الملف: bytes null");
      return;
    }

    print('📦 تم تحميل الملف: ${platformFile.name}');

    try {
      String? chatText;

      if (platformFile.name.endsWith('.zip')) {
        print('🗜 فك ضغط ملف ZIP');
        final archive = ZipDecoder().decodeBytes(bytes);
        final fileEntry = archive.files.where((f) {
          print('🔍 داخل الأرشيف: ${f.name}');
          return f.name.endsWith('_chat.txt');
        }).toList();

        if (fileEntry.isEmpty) {
          throw Exception("ما وجدنا ملف ينتهي بـ _chat.txt داخل الضغط.");
        }

        final chatEntry = fileEntry.first;
        chatText = utf8.decode(chatEntry.content);
        print('📄 تم قراءة محتوى _chat.txt');
      } else if (platformFile.name.endsWith('.txt')) {
        chatText = utf8.decode(bytes);
        print('📄 تم قراءة ملف TXT');
      }

      if (chatText != null) {
        print('📊 بدء تحليل النص');
        handleParsedText(chatText);
      } else {
        setState(() => error = "الملف غير مدعوم.");
      }
    } catch (e) {
      print('❌ خطأ: $e');
      setState(() => error = "صار خطأ أثناء تحليل الملف: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تحليل قروب الواتساب')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _pickAndParseFile,
              icon: const Icon(Icons.upload_file),
              label: const Text("تحميل ملف المحادثة"),
            ),
            const SizedBox(height: 10),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),
            if (debugMessage != null)
              Text(debugMessage!),
            const SizedBox(height: 20),
            Text("عدد الرسائل: ${parsedMessages.length}"),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: messagesByUser.length,
                itemBuilder: (context, index) {
                  final user = messagesByUser.keys.elementAt(index);
                  final messages = messagesByUser[user] ?? [];
                  return ListTile(
                    title: Text(user),
                    subtitle: Text("${messages.length} رسالة"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
