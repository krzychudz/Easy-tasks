import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../database/database_interface.dart';

class SQLliteDatabase implements DatabaseInterface {
  Database _database;

  @override
  void dropTable() {
    // TODO: implement dropTable
  }

  @override
  Future<List<Map<String, dynamic>>> getAllTableData(String tableName) async {
    _database = await getDatabase();
    return _database.query(tableName);
  }

  @override
  void getDataByid() {
    // TODO: implement getDataByid
  }

  @override
  void removeDataById() {
    // TODO: implement removeDataById
  }

  @override
  Future<int> insertData(String tableName, Map<String, dynamic> data) async {
    _database = await getDatabase();
    return await _database.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> createTableIfNotExists(
      String tableName, String builderString) async {
    _database = await getDatabase();
    return await _database
        .execute('CREATE TABLE IF NOT EXISTS $tableName $builderString');
  }

  Future<Database> getDatabase() async {
    print('here');
    if (_database != null) {
      print('here1');
      return _database;
    }
    return openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) => {},
      version: 1,
    );
  }
}
