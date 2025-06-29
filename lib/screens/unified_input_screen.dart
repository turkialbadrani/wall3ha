
import 'package:flutter/material.dart';
import '../services/response_generator.dart';
import '../widgets/input_field_section_widget.dart';
import '../widgets/options_selector_section_widget.dart';
import '../widgets/generate_button_widget.dart';
import '../widgets/generated_message_box_widget.dart';
import '../widgets/bottom_actions_bar_widget.dart';

class UnifiedInputScreen extends StatefulWidget {
  const UnifiedInputScreen({super.key});

  @override
  State<UnifiedInputScreen> createState() => _UnifiedInputScreenState();
}

class _UnifiedInputScreenState extends State<UnifiedInputScreen> {
  final TextEditingController _controller = TextEditingController();

  String selectedStyle = 'ساخر';
  String selectedDialect = 'سعودي';
  String selectedLength = 'قصيرة';
  String generatedMessage = '';
  bool isLoading = false;

  Future<void> generateResponse() async {
    setState(() {
      isLoading = true;
      generatedMessage = '';
    });

    try {
      final msg = await ResponseService().generate(
        input: _controller.text,
        inputType: 'رسالة',
        style: selectedStyle,
        dialect: selectedDialect,
        length: selectedLength,
      );
      setState(() => generatedMessage = msg);
    } catch (e) {
      setState(() => generatedMessage = '❌ صار خطأ أثناء التوليد');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text("🔥 ولّعها الموحدة")),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFieldSectionWidget(controller: _controller),
                    const SizedBox(height: 16),
                    OptionsSelectorSectionWidget(
                      selectedStyle: selectedStyle,
                      selectedDialect: selectedDialect,
                      selectedLength: selectedLength,
                      onChanged: (val, type) {
                        setState(() {
                          if (type == 'style') selectedStyle = val;
                          if (type == 'dialect') selectedDialect = val;
                          if (type == 'length') selectedLength = val;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    GenerateButtonWidget(
                      onPressed: generateResponse,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 24),
                    GeneratedMessageBoxWidget(message: generatedMessage),
                  ],
                ),
              ),
            ),
            const Divider(),
            const BottomActionsBarWidget(),
          ],
        ),
      ),
    );
  }
}
