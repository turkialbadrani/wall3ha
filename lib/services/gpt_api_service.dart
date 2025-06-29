
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_credit_service.dart';

class ApiManager {
  final String userApiKey;
  final String fallbackApiKey;
  final String model;
  final TokenCreditService creditService = TokenCreditService();

  ApiManager({
    required this.userApiKey,
    required this.fallbackApiKey,
    this.model = 'gpt-4o',
  });

  Future<Map<String, dynamic>> sendChatMessage(String prompt) async {
    if (!creditService.canGenerate(100)) {
      return {
        'reply': '⚠️ رصيدك من النقاط الذكية غير كافٍ للتوليد.',
        'fallback': false,
        'usage': {
          'prompt_tokens': 0,
          'completion_tokens': 0,
          'total_tokens': 0,
          'estimated_cost_usd': 0.0
        }
      };
    }

    try {
      return await _attemptRequest(userApiKey, prompt, isFallback: false);
    } catch (e) {
      print('⚠️ Fallback triggered: \$e');
      return await _attemptRequest(fallbackApiKey, prompt, isFallback: true);
    }
  }

  Future<Map<String, dynamic>> _attemptRequest(String key, String prompt, {required bool isFallback}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer \$key',
    };

    final body = jsonEncode({
      'model': model,
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
      'temperature': 0.7,
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final reply = data['choices'][0]['message']['content'];
      final usage = data['usage'];

      final totalUsed = usage['total_tokens'];
      creditService.deductTokens(totalUsed);

      return {
        'reply': reply,
        'fallback': isFallback,
        'usage': {
          'prompt_tokens': usage['prompt_tokens'],
          'completion_tokens': usage['completion_tokens'],
          'total_tokens': totalUsed,
          'estimated_cost_usd': _calculateCost(totalUsed),
        }
      };
    } else {
      throw Exception('API Error \${response.statusCode}: \${response.body}');
    }
  }

  double _calculateCost(int totalTokens) {
    return totalTokens * 0.005 / 1000;
  }
}
