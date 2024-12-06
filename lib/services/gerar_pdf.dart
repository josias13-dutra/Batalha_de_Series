import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../models/serie.dart.dart';


class PDFService {
  static Future<void> generateReport(List<Serie> series) async {
    final pdf = pw.Document();

    // Adiciona uma página ao PDF com detalhes das séries
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Relatório de Séries',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 16),
            ...series.map((serie) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Nome: ${serie.nome}',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text('Gênero: ${serie.genero}', style: const pw.TextStyle(fontSize: 14)),
                  pw.Text('Descrição: ${serie.descricao}', style: const pw.TextStyle(fontSize: 14)),
                  pw.Text('Pontuação: ${serie.pontuacao}', style: const pw.TextStyle(fontSize: 14)),
                  pw.Text('Vitórias: ${serie.vitorias ?? 0}', style: const pw.TextStyle(fontSize: 14)),
                  pw.Divider(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );

    // Obtém o diretório onde o PDF será salvo
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/relatorio_series.pdf');

    // Salva o PDF no arquivo
    await file.writeAsBytes(await pdf.save());

    // Abre o arquivo para o usuário baixar ou visualizar
    await OpenFile.open(file.path);
  }
}
