import 'package:flutter/material.dart';
import 'selection_controls.dart';

Widget buildOptions(String selectedStyle, String selectedDialect, String selectedLength,
    Function(String val, String type) onChanged) {
  return Column(
    children: [
      SelectionChips(
        title: '🧠 اختر الأسلوب:',
        options: ['ساخر', 'رومانسي', 'حزين', 'رسمي'],
        selected: selectedStyle,
        onSelected: (val) => onChanged(val, 'style'),
      ),
      SelectionChips(
        title: '🌍 اختر اللهجة:',
        options: ['سعودي', 'مصري', 'سوداني', 'مغربي'],
        selected: selectedDialect,
        onSelected: (val) => onChanged(val, 'dialect'),
      ),
      SelectionChips(
        title: '📝 اختر الطول:',
        options: ['تلقائي', 'قصيرة', 'متوسطة', 'طويلة'],
        selected: selectedLength,
        onSelected: (val) => onChanged(val, 'length'),
      ),
    ],
  );
}
