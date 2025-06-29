import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('ℹ️ عن التطبيق')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'تطبيق ولّعها 🔥',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'ولّعها هو تطبيق ذكي يساعدك ترد على الرسائل، تحلل قروبات الواتساب، وتصيغ كلام يناسبك بأي لهجة وأسلوب.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'النسخة الحالية: V2_5',
                style: TextStyle(color: Colors.white54),
              ),
              SizedBox(height: 24),
              Text(
                '© جميع الحقوق محفوظة لأبو عزّام، 2025',
                style: TextStyle(fontSize: 14, color: Colors.white38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
