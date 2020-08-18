abstract class DatabaseInterface {
  Future<List<Map<String, dynamic>>> getAllTableData(String tableName);
  void getDataByid();
  Future<int> removeDataById(String tableName, String id);
  void dropTable();
  Future<int> insertData(String tableName, Map<String, dynamic> data);
  Future<void> createTableIfNotExists(String tableName, String builderString);
}