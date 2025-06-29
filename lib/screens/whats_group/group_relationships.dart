
import 'package:flutter/material.dart';
import '../../services/response_generator.dart';

class GroupRelationships extends StatefulWidget {
  final List<Map<String, dynamic>> parsedMessages;
  final List<String> participants;
  final Function(String)? onGenerated;

  const GroupRelationships({
    super.key,
    required this.parsedMessages,
    required this.participants,
    this.onGenerated,
  });

  @override
  State<GroupRelationships> createState() => _GroupRelationshipsState();
}

class _GroupRelationshipsState extends State<GroupRelationships> {
  String? relationshipSummary;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    analyzeRelationships();
  }

  Future<void> analyzeRelationships() async {
    Map<String, int> mentionCount = {};
    Map<String, Set<String>> repliesTo = {};

    for (var msg in widget.parsedMessages) {
      final sender = msg['name'];
      final text = (msg['text'] ?? '').toLowerCase();

      for (var name in widget.participants) {
        if (name.toLowerCase() != sender.toLowerCase() && text.contains(name.toLowerCase())) {
          mentionCount[name] = (mentionCount[name] ?? 0) + 1;
          repliesTo.putIfAbsent(sender, () => {}).add(name);
        }
      }
    }

    final mentions = mentionCount.entries.map((e) => "${e.key}: ${e.value} مرّة").join("\n");
    final replyMap = repliesTo.entries.map((e) => "${e.key} يرد على: ${e.value.join(", ")}").join("\n");

    final prompt = """
📌 تحليل العلاقات داخل القروب:

- عدد مرات الذكر:
$mentions

- أنماط الردود:
$replyMap

🧠 صف لنا التفاعلات داخل القروب، من اللي يطنّش؟ من دايم يرد؟ من واضح إنه يتفاعل كثير؟ بأسلوب ذكي وعفوي.
""";

    final result = await ResponseService().generate(
      input: prompt,
      inputType: 'تحليل العلاقات',
      style: 'تحليلي اجتماعي',
      dialect: 'سعودي',
      length: 'متوسط',
    );

    setState(() {
      relationshipSummary = result;
      loading = false;
    });

    if (widget.onGenerated != null) {
      widget.onGenerated!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      );
    }

    return Card(
      color: Colors.teal[900],
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          relationshipSummary ?? '',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
