
import 'package:flutter/material.dart';
import '../../services/response_generator.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class GroupImprovementTip extends StatefulWidget {
  final String summary;
  final List<String> topWords;
  final List<String> topEmojis;
  final List<String> activeHours;
  final Function(String)? onGenerated;

  const GroupImprovementTip({
    super.key,
    required this.summary,
    required this.topWords,
    required this.topEmojis,
    required this.activeHours,
    this.onGenerated,
  });

  @override
  State<GroupImprovementTip> createState() => _GroupImprovementTipState();
}

class _GroupImprovementTipState extends State<GroupImprovementTip> {
  String? suggestion;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    generateTip();
  }

  Future<void> generateTip() async {
    final prompt = """
هذا القروب:
- وصفه: ${widget.summary}
- الكلمات المتكررة: ${widget.topWords.join(", ")}
- الإيموجيات: ${widget.topEmojis.join(" ")}
- أوقات النشاط: ${widget.activeHours.join(", ")}

🎯 المطلوب:
وش تقترح نعدّل أو نضيف في هذا القروب؟ عطنا اقتراحات حقيقية، بأسلوب ذكي، واقعي، وكأنك تنصح صديق.
""";

    final result = await ResponseService().generate(
      input: prompt,
      inputType: 'نصيحة لتحسين القروب',
      style: 'خبير اجتماعي',
      dialect: 'سعودي',
      length: 'قصيرة',
    );

    setState(() {
      suggestion = result;
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
      color: Colors.blueGrey[800],
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(suggestion ?? '', style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: suggestion ?? ''));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("📋 تم نسخ التوصية!")),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text("انسخ"),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => Share.share(suggestion ?? ''),
                  icon: const Icon(Icons.share),
                  label: const Text("شارك"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
