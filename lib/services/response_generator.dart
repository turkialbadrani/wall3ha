import 'greeting_helper.dart';

class ResponseService {
  final _gpt = OpenAIUnifiedHelper();

  Future<String> generate({
    required String input,
    required String inputType,
    required String style,
    required String dialect,
    required String length,
  }) async {
    return await _gpt.generateReply(
      inputType: inputType,
      message: input,
      style: style,
      dialect: dialect,
      length: length,
    );
  }
}
