
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'group_summary_export_body.dart';

class GroupSummaryExport extends StatelessWidget {
  final String summary;
  final String tip;
  final String relationships;
  final Map<String, String> memberDescriptions;

  const GroupSummaryExport({
    super.key,
    required this.summary,
    required this.tip,
    required this.relationships,
    required this.memberDescriptions,
  });

  Future<void> _generatePdf(BuildContext context) async {
    final doc = pw.Document();
    doc.addPage(
      GroupSummaryExportBody.build(
        summary: summary,
        tip: tip,
        relationships: relationships,
        memberDescriptions: memberDescriptions,
      ),
    );
    await Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton.icon(
        onPressed: () => _generatePdf(context),
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text("تحميل PDF"),
      ),
    );
  }
}
