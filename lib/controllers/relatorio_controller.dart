import '../services/gerar_pdf.dart';

import '../services/database_service.dart';

class RelatorioController {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<void> gerarRelatorio() async {
    final series = await _dbService.getAllSeries();
    await PDFService.generateReport(series);
  }
}
