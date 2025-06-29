
import 'package:flutter/material.dart';

class TokenUsageWidget extends StatelessWidget {
  final int totalTokens;
  final double estimatedCost;
  final bool isFallback;

  const TokenUsageWidget({
    super.key,
    required this.totalTokens,
    required this.estimatedCost,
    required this.isFallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isFallback ? Colors.red[900] : Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isFallback
                  ? '⚠️ تم استخدام مفتاح الطوارئ'
                  : '🧠 تم استخدام مفتاحك الشخصي',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              '📊 التوكنات المستخدمة: $totalTokens',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              '💸 التكلفة التقريبية: \$${estimatedCost.toStringAsFixed(4)}',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
