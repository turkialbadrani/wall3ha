
import 'package:flutter/material.dart';
import 'group_members_analysis.dart';
import 'group_relationships.dart';
import 'group_improvement_tip.dart';
import 'group_self_profile.dart';
import 'group_summary_export.dart';
import '../../widgets/bottom_actions_bar_widget.dart';

class WhatsGroupAnalysisBody extends StatelessWidget {
  final List<Map<String, dynamic>> parsedMessages;
  final Map<String, List<String>> messagesByUser;
  final List<String> topWords;
  final List<String> topEmojis;
  final List<String> activeHours;
  final String groupSummary;
  final String? selectedUser;
  final String? tipFromGPT;
  final String? relationshipsFromGPT;

  const WhatsGroupAnalysisBody({
    super.key,
    required this.parsedMessages,
    required this.messagesByUser,
    required this.topWords,
    required this.topEmojis,
    required this.activeHours,
    required this.groupSummary,
    required this.selectedUser,
    required this.tipFromGPT,
    required this.relationshipsFromGPT,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GroupMembersAnalysis(messagesByUser: messagesByUser),
        GroupRelationships(
          parsedMessages: parsedMessages,
          participants: messagesByUser.keys.toList(),
        ),
        GroupImprovementTip(
          summary: groupSummary,
          topWords: topWords,
          topEmojis: topEmojis,
          activeHours: activeHours,
        ),
        GroupSelfProfile(
          selectedUser: selectedUser!,
          messages: messagesByUser[selectedUser] ?? [],
        ),
        GroupSummaryExport(
          summary: groupSummary,
          tip: tipFromGPT ?? '...',
          relationships: relationshipsFromGPT ?? '...',
          memberDescriptions: {
            for (var e in messagesByUser.entries)
              e.key: e.value.take(1).join(" ")
          },
        ),
        const BottomActionsBarWidget(),
      ],
    );
  }
}
