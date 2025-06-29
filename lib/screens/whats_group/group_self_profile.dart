
import 'package:flutter/material.dart';
import '../../services/response_generator.dart';

class GroupSelfProfile extends StatefulWidget {
  final String selectedUser;
  final List<String> messages;

  const GroupSelfProfile({
    super.key,
    required this.selectedUser,
    required this.messages,
  });

  @override
  State<GroupSelfProfile> createState() => _GroupSelfProfileState();
}

class _GroupSelfProfileState extends State<GroupSelfProfile> {
  String? profileSummary;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    generateSelfProfile();
  }

  Future<void> generateSelfProfile() async {
    final prompt = """
هذه مقتطفات من رسائل "${widget.selectedUser}" في قروب واتساب:
${widget.messages.take(15).join("\n")}

🧠 المطلوب:
صف لنا هذا العضو بطريقة تحليلية خفيفة الظل، كأنك تصف شخصيته من واقع كلامه.
- هل هو ساخر؟ رسمي؟ تفاعلي؟
- وش دوره في القروب؟
- وش نغزته أو طريقته اللي يميز فيها؟
""";

    final result = await ResponseService().generate(
      input: prompt,
      inputType: 'تحليل شخصية عضو',
      style: 'بطاقة شخصية',
      dialect: 'سعودي',
      length: 'متوسط',
    );

    setState(() {
      profileSummary = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      );
    }

    return Card(
      color: Colors.deepPurple[700],
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          profileSummary ?? '',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
