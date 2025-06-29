import 'package:flutter/material.dart';
import '../screens/whats_group_screen.dart'; // تعديل المسار الصحيح حسب مكان الملف الفعلي

class BottomActionsBarWidget extends StatelessWidget {
  const BottomActionsBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.group, color: Colors.amber),
            tooltip: 'تحليل قروب الواتساب',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WhatsGroupScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.grey),
            tooltip: 'حول التطبيق',
            onPressed: () {
              // TODO: ربط شاشة about_screen إذا جاهزة
            },
          ),
        ],
      ),
    );
  }
}
