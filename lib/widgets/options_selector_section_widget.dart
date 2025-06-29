
import 'package:flutter/material.dart';
import '../screens/options_selector.dart';

class OptionsSelectorSectionWidget extends StatelessWidget {
  final String selectedStyle;
  final String selectedDialect;
  final String selectedLength;
  final Function(String, String) onChanged;

  const OptionsSelectorSectionWidget({
    Key? key,
    required this.selectedStyle,
    required this.selectedDialect,
    required this.selectedLength,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildOptions(selectedStyle, selectedDialect, selectedLength, onChanged);
  }
}
