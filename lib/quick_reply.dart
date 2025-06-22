
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuickReplyPage extends StatefulWidget {
  const QuickReplyPage({super.key});

  @override
  State<QuickReplyPage> createState() => _QuickReplyPageState();
}

class _QuickReplyPageState extends State<QuickReplyPage> {
  final TextEditingController _controller = TextEditingController();
  String _selectedTone = 'قصف جبهة';
  String _selectedDialect = 'نجدي';
  String _reply = '';
  bool _loading = false;

  Future<void> getReply(String inputText) async {
    if (inputText.isEmpty) return;

    setState(() {
      _loading = true;
      _reply = '';
    });

    const apiKey = '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';

    final prompt = "رد على هذه الرسالة بأسلوب $_selectedTone وبلهجة $_selectedDialect: ${_controller.text}";

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4o',
        'messages': [
          {'role': 'system', 'content': 'أنت مساعد ذكي ترد بأسلوب لبق وذكي.'},
          {'role': 'user', 'content': prompt}
        ],
      }),
    );

    final decoded = utf8.decode(response.bodyBytes);
    final data = json.decode(decoded);

    setState(() {
      _reply = data['choices'][0]['message']['content'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رد سريع')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedTone,
              items: ['قصف جبهة', 'حزين', 'رسمي', 'غبي']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedTone = v!),
            ),
            DropdownButton<String>(
              value: _selectedDialect,
              items: ['نجدي', 'مصري', 'سوداني', 'سوري']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedDialect = v!),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'اكتب أو الصق الرسالة هنا...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loading ? null : () => getReply(_controller.text),
              child: const Text('ولّعها'),
            ),
            const SizedBox(height: 20),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (_reply.isNotEmpty)
              Text(
                _reply,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontSize: 16),
              )
          ],
        ),
      ),
    );
  }
}
