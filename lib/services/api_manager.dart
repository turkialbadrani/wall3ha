
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  final String userApiKey;
  final String fallbackApiKey;
  final String model;

  ApiManager({
    required this.userApiKey,
    required this.fallbackApiKey,
    this.model = 'gpt-4o',
  });

  Future<Map<String, dynamic>> sendChatMessage(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
      'temperature': 0.7,
    });

    try {
      return await _attemptRequest(userApiKey, body, isFallback: false);
    } catch (e) {
      print('⚠️ Fallback triggered: $e');
      return await _attemptRequest(fallbackApiKey, body, isFallback: true);
    }
  }

  Future<Map<String, dynamic>> _attemptRequest(String key, String body, {required bool isFallback}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer \$key',
    };

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final reply = data['choices'][0]['message']['content'];
      final usage = data['usage'];

      return {
        'reply': reply,
        'fallback': isFallback,
        'usage': {
          'prompt_tokens': usage['prompt_tokens'],
          'completion_tokens': usage['completion_tokens'],
          'total_tokens': usage['total_tokens'],
          'estimated_cost_usd': _calculateCost(usage['total_tokens']),
        }
      };
    } else {
      throw Exception('API Error ${response.statusCode}: ${response.body}');
    }
  }

  double _calculateCost(int totalTokens) {
    // Approximate GPT-4o pricing (input $0.005, output $0.015) per 1K tokens
    return totalTokens * 0.005 / 1000;
  }
}
