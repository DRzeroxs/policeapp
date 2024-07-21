import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/incidencia_model.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'incidencias.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidencias(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        fecha TEXT,
        descripcion TEXT,
        fotoPath TEXT,
        audioPath TEXT
      )
    ''');
  }

  Future<int> insertIncidencia(Incidencia incidencia) async {
    final db = await database;
    return await db.insert('incidencias', incidencia.toMap());
  }

  Future<List<Incidencia>> getIncidencias() async {
    final db = await database;
    final res = await db.query('incidencias');
    return res.isNotEmpty
        ? res.map((c) => Incidencia(
              id: c['id'] as int?,
              titulo: c['titulo'] as String,
              fecha: DateTime.parse(c['fecha'] as String),
              descripcion: c['descripcion'] as String,
              fotoPath: c['fotoPath'] as String?,
              audioPath: c['audioPath'] as String?,
            )).toList()
        : [];
  }

  Future<void> deleteAllIncidencias() async {
    final db = await database;
    await db.delete('incidencias');
  }
}
