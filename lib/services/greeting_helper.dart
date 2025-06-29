
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIUnifiedHelper {
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  Future<String> generateReply({
    required String inputType,
    required String message,
    required String style,
    required String dialect,
    required String length,
  }) async {
    final prompt = '''
اكتب ردًا بأسلوب "$style" وبلهجة "$dialect" على النوع "$inputType"، بحيث يكون طول الرد "$length".
المحتوى المدخل: $message
''';

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-4o",
        "messages": [
          {"role": "user", "content": prompt}
        ],
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data["choices"][0]["message"]["content"];
    } else {
      final error = jsonDecode(response.body);
      final msg = error["error"]?["message"] ?? "خطأ غير معروف";
      throw Exception("فشل في الاتصال بـ OpenAI: ${response.statusCode} - $msg");
    }
  }
}
