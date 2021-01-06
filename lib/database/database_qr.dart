import 'package:appcheck/database/table_sql.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseQR {
  static const String DB_NAME = 'qrdata.db';
  static const DB_VERSION = 1;
  static Database _database;

  DatabaseQR._internal();
  static final DatabaseQR instance = DatabaseQR._internal();

  Database get database => _database;
  

  static const initScrips = [TableSql.CREATE_TABLE_QUERY];
  static const magrationScrips = [TableSql.CREATE_TABLE_QUERY];

  init() async {
    _database = await openDatabase(join(await getDatabasesPath(), DB_NAME),
        onCreate: (db, version) {
      initScrips.forEach((script) async => await db.execute(script));
    }, onUpgrade: (db, oldVersion, newVersion) {
      magrationScrips.forEach((script) async => await db.execute(script));
    }, version: DB_VERSION);
  }
}
