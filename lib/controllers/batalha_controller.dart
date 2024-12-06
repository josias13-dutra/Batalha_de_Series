
import '../models/serie.dart.dart';
import '../services/database_service.dart';

class BatalhaController {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<void> registrarVitoria(Serie serie) async {
    serie.vitorias++;
    await _dbService.updateSerie(serie);
  }

  Future<List<Serie>> getSeries() async {
    return await _dbService.getAllSeries();
  }
}
