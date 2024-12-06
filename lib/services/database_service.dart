import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/serie.dart.dart';


class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('series.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE series (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        genero TEXT NOT NULL,
        descricao TEXT NOT NULL,
        capa TEXT NOT NULL,
        pontuacao REAL NOT NULL,
        vitorias INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Serie>> getAllSeries() async {
    final db = await database;
    final result = await db.query('series');
    return result.map((json) => Serie.fromMap(json)).toList();
  }

  Future<void> addSerie(Serie serie) async {
    final db = await database;
    await db.insert('series', serie.toMap());
  }

  Future<void> updateSerie(Serie serie) async {
    final db = await database;
    await db.update('series', serie.toMap(), where: 'id = ?', whereArgs: [serie.id]);
  }
}
