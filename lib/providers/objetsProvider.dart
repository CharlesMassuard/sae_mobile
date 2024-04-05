import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sae_mobile/models/objets.dart';

class MesObjetsProvider {
  static const String TABLE_MES_OBJETS = 'MesObjets';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NOM_OBJET = 'nomObjet';
  static const String COLUMN_DESCRIPTION_OBJET = 'descriptionObjet';

  MesObjetsProvider._();
  static final MesObjetsProvider db = MesObjetsProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await getDatabaseInstance();
    return _database!;
  }

  Future<Database> getDatabaseInstance() async {
    String path = join(await getDatabasesPath(), 'mes_objets.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $TABLE_MES_OBJETS ("
              "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
              "$COLUMN_NOM_OBJET TEXT, "
              "$COLUMN_DESCRIPTION_OBJET TEXT)");
        });
  }

  Future<List<MesObjets>?>? getMesObjets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_MES_OBJETS);

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return MesObjets(
        id: maps[i]['id'],
        nomObjet: maps[i]['nomObjet'],
        descriptionObjet: maps[i]['descriptionObjet'],
      );
    });
  }

  Future<int> insert(MesObjets mesObjets) async {
    final db = await database;
    return await db.insert(TABLE_MES_OBJETS, mesObjets.toMap());
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      TABLE_MES_OBJETS,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(MesObjets mesObjets) async {
    final db = await database;
    return await db.update(
      TABLE_MES_OBJETS,
      mesObjets.toMap(),
      where: "id = ?",
      whereArgs: [mesObjets.id],
    );
  }
}