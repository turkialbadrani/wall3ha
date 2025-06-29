
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/response_generator.dart';
import '../widgets/input_field_section_widget.dart';
import '../widgets/options_selector_section_widget.dart';
import '../widgets/generate_button_widget.dart';
import '../widgets/generated_message_box_widget.dart';
import '../widgets/bottom_actions_bar_widget.dart';

class WallaahaScreen extends StatefulWidget {
  const WallaahaScreen({super.key});

  @override
  State<WallaahaScreen> createState() => _WallaahaScreenState();
}

class _WallaahaScreenState extends State<WallaahaScreen> {
  final TextEditingController _controller = TextEditingController();
  String selectedStyle = 'ساخر';
  String selectedDialect = 'سعودي';
  String selectedLength = 'قصيرة';
  String selectedMood = 'عادي';
  String selectedIntent = 'رد طبيعي';

  String generatedMessage = '';
  bool isLoading = false;
  List<String> previousMessages = [];

  Future<void> generateResponse() async {
    setState(() {
      isLoading = true;
      generatedMessage = '';
    });

    await Future.delayed(const Duration(milliseconds: 500)); // مؤثر بسيط

    try {
      final msg = await ResponseService().generate(
        input: _controller.text,
        inputType: 'رسالة',
        style: '$selectedStyle - $selectedMood',
        dialect: selectedDialect,
        length: selectedLength,
      );
      setState(() {
        generatedMessage = msg;
        previousMessages.insert(0, msg);
        if (previousMessages.length > 5) previousMessages.removeLast();
      });
    } catch (e) {
      setState(() => generatedMessage = '❌ صار خطأ أثناء التوليد');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildMoodSelector() {
    final moods = ['عادي', 'متفائل', 'حزين', 'متحمس'];
    return DropdownButtonFormField(
      value: selectedMood,
      items: moods.map((m) => DropdownMenuItem(value: m, child: Text("🌀 $m"))).toList(),
      onChanged: (val) => setState(() => selectedMood = val.toString()),
      decoration: const InputDecoration(labelText: "المود"),
    );
  }

  Widget _buildIntentSelector() {
    final intents = ['رد طبيعي', 'تحفيزي', 'تنبيه مهذب', 'تعاطف', 'رد ذكي ساخر'];
    return DropdownButtonFormField(
      value: selectedIntent,
      items: intents.map((i) => DropdownMenuItem(value: i, child: Text("🎯 $i"))).toList(),
      onChanged: (val) => setState(() => selectedIntent = val.toString()),
      decoration: const InputDecoration(labelText: "الغرض من الرد"),
    );
  }

  Widget _buildPreviousReplies() {
    if (previousMessages.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Text("🕓 ردود سابقة:", style: TextStyle(fontWeight: FontWeight.bold)),
        ...previousMessages.map((msg) => Card(
          color: Colors.grey[900],
          child: ListTile(
            title: Text(msg, style: const TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: const Icon(Icons.copy, color: Colors.amber),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: msg));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("📋 تم نسخ الرد")));
              },
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildCopyShareBar() {
    if (generatedMessage.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.copy, color: Colors.amber),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: generatedMessage));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("📋 تم نسخ الرد")));
          },
        ),
        const Text("نموذج: GPT-4o | تكلفة تقديرية: 12 نقطة", style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text("🔥 ولّعها")),
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
                    _buildMoodSelector(),
                    const SizedBox(height: 16),
                    _buildIntentSelector(),
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
                    _buildCopyShareBar(),
                    _buildPreviousReplies(),
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
