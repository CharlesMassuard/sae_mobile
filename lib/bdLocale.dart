import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


Future<void> initDatabase() async {
  // Open the database
  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
        'CREATE TABLE MesObjets (id INTEGER PRIMARY KEY AUTOINCREMENT, nomObjet TEXT, descriptionObjet TEXT)',
      );
    },
    version: 1,
  );
}