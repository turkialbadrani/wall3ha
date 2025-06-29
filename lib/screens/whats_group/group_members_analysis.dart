
import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class GroupMembersAnalysis extends StatelessWidget {
  final Map<String, List<String>> messagesByUser;

  const GroupMembersAnalysis({super.key, required this.messagesByUser});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: messagesByUser.entries.map((entry) {
        final name = entry.key;
        final messages = entry.value;
        final userId = name.replaceAll(" ", "_");

        return FutureBuilder<Map<String, dynamic>?>(
          future: FirebaseService.getAnalysisIfExists(userId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.all(8),
                child: LinearProgressIndicator(),
              );
            }

            final cached = snapshot.data;
            final analysis = cached?['basic_analysis'] ?? 'لم يتم التحليل بعد';
            final rating = cached?['average_rating']?.toDouble() ?? 0.0;

            return Card(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Text("عدد الرسائل: ${messages.length}", style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(analysis, style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text("⭐️ تقييم القروب له: ${rating.toStringAsFixed(1)}", style: const TextStyle(color: Colors.amber)),
                        const Spacer(),
                        PopupMenuButton<int>(
                          icon: const Icon(Icons.star_border, color: Colors.amber),
                          onSelected: (value) async {
                            await FirebaseService.saveRatingToFirebase(userId, value);
                          },
                          itemBuilder: (context) => List.generate(5, (i) => PopupMenuItem(
                            value: i + 1,
                            child: Text("⭐️ ${i + 1}"),
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
