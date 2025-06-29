import 'package:flutter/material.dart';

Widget buildActionSection(bool isLoading, VoidCallback onGenerate,
    String errorMessage, String generatedResponse) {
  return Column(
    children: [
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: isLoading ? null : onGenerate,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text('ولّعها'),
      ),
      const SizedBox(height: 30),
      if (errorMessage.isNotEmpty)
        Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      if (generatedResponse.isNotEmpty)
        SelectableText(
          generatedResponse,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
    ],
  );
}
