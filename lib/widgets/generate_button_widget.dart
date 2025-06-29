
import 'package:flutter/material.dart';

class GenerateButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GenerateButtonWidget({Key? key, required this.onPressed, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: const Icon(Icons.flash_on),
      label: isLoading
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
          : const Text("ولّعها"),
    );
  }
}
