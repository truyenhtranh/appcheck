import 'package:appcheck/database/database_qr.dart';
import 'package:appcheck/model/qr_data.dart';
import 'package:sqflite/sqflite.dart';

class TableSql {
  static const TABLE_NAME = 'qrsql';
  static const CREATE_TABLE_QUERY = '''
      CREATE TABLE $TABLE_NAME(
        id INTEGER PRIMARY KEY,
        content TEXT
      );
  ''';

  static const DROP_TABLE_QUERY = '''
  DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insert(QRdata qRdata) {
    final Database db = DatabaseQR.instance.database;

    return db.insert(
      TABLE_NAME,
      qRdata.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(QRdata qRdata) async {
    final Database db = DatabaseQR.instance.database;
    await db.delete(TABLE_NAME, where: 'id = ?', whereArgs: [qRdata.id]);
  }

  Future<List<QRdata>> selectAll() async {

    final Database db = DatabaseQR.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('qRdata');

    return List.generate(maps.length, (index) {
      return QRdata.fromData(
        maps[index]['id'],
        maps[index]['content'],
      );
    });
  }
}
