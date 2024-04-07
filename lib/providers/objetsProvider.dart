import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sae_mobile/models/objets.dart';

class MesObjetsProvider {
  final db = openDatabase("database.db");

  Future<List<Objet>?> getMesObjets() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('MesObjets');
    return List.generate(maps.length, (i) {
      return Objet(
        id: maps[i]['id'],
        nomObjet: maps[i]['nomObjet'],
        descriptionObjet: maps[i]['descriptionObjet'],
        usernameOwner: maps[i]['usernameOwner'],
      );
    });
  }

  removeObjet(int id) {
    db.then((db) {
      db.delete('MesObjets', where: 'id = ?', whereArgs: [id]);
    });
  }

  removeALlObjets() {
    db.then((db) {
      db.delete('MesObjets');
    });
  }
}