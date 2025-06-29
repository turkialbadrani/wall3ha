
import 'package:flutter/material.dart';

class FlameEffect extends StatelessWidget {
  final bool show;

  const FlameEffect({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: show
          ? Icon(
              Icons.local_fire_department,
              key: const ValueKey('flame'),
              color: Colors.deepOrangeAccent,
              size: 80,
            )
          : const SizedBox.shrink(key: ValueKey('empty')),
    );
  }
}
