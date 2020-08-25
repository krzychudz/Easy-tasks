import 'package:easy_notes/database/database_interface.dart';
import 'package:easy_notes/database/sqllite_databes.dart';
import 'package:inject/inject.dart';

@module
class DatabaseModule {
  @provide
  DatabaseInterface databaseInterface() => SQLliteDatabase();
}