
import 'package:pdf/widgets.dart' as pw;

class GroupSummaryExportBody {
  static pw.MultiPage build({
    required String summary,
    required String tip,
    required String relationships,
    required Map<String, String> memberDescriptions,
  }) {
    return pw.MultiPage(
      build: (context) => [
        pw.Text("📊 تقرير تحليل القروب", style: pw.TextStyle(fontSize: 20)),
        pw.SizedBox(height: 16),
        pw.Text("🧠 الملخص العام:"),
        pw.Text(summary),
        pw.SizedBox(height: 12),
        pw.Text("💡 التوصية:"),
        pw.Text(tip),
        pw.SizedBox(height: 12),
        pw.Text("🤝 العلاقات:"),
        pw.Text(relationships),
        pw.SizedBox(height: 12),
        pw.Text("👥 تحليل الأعضاء:"),
        ...memberDescriptions.entries.map((e) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Text("• ${e.key}: ${e.value}"),
            )),
      ],
    );
  }
}
