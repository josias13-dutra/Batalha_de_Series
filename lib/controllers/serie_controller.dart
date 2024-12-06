import '../models/serie.dart.dart';
import '../services/database_service.dart';

class SerieController {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<void> addSerie(Serie serie) async {
    await _dbService.addSerie(serie);
  }

  Future<List<Serie>> getAllSeries() async {
    return await _dbService.getAllSeries();
  }
}
