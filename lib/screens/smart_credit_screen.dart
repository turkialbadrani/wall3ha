
import 'package:flutter/material.dart';
import '../services/token_credit_service.dart';

class SmartCreditScreen extends StatefulWidget {
  const SmartCreditScreen({super.key});

  @override
  State<SmartCreditScreen> createState() => _SmartCreditScreenState();
}

class _SmartCreditScreenState extends State<SmartCreditScreen> {
  final TokenCreditService creditService = TokenCreditService();

  @override
  Widget build(BuildContext context) {
    final int balance = creditService.currentBalance;

    Color getColor(int value) {
      if (value > 3000) return Colors.green;
      if (value > 1000) return Colors.orange;
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("رصيدك الذكي")),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          color: getColor(balance).withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("📊 النقاط الذكية المتبقية لديك:", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                Text(
                  "$balance نقطة",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: getColor(balance),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "يتم خصم النقاط الذكية عند استخدام الذكاء الاصطناعي. إذا انتهت، لن تتمكن من التوليد حتى تعبئة الرصيد.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
