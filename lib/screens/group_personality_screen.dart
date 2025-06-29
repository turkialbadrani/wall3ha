
import 'package:flutter/material.dart';

class GroupPersonalityScreen extends StatelessWidget {
  const GroupPersonalityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> members = [
      {
        'name': 'حسين ال سالم',
        'emoji': '🧠',
        'desc': 'فيلسوف القروب – ساخر بنبرة مثقفة، تعليقاته فيها عمق ونغزات باردة.'
      },
      {
        'name': 'الثبيتي ماجد',
        'emoji': '🤣',
        'desc': 'مدفع الطقطقة – أسرع واحد في التحشيش، يحوّل أي موضوع لفلم أكشن ساخر.'
      },
      {
        'name': 'تركي الحربي',
        'emoji': '🧱',
        'desc': 'المحلّل الشعبي – يقط نكت، يرقب الوضع، ويقلب الجدية طقطقة بذكاء شعبي.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('تحليل أعضاء القروب'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.grey[900],
            child: ListTile(
              leading: Text(member['emoji']!, style: const TextStyle(fontSize: 32)),
              title: Text(
                member['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                member['desc']!,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          );
        },
      ),
    );
  }
}
