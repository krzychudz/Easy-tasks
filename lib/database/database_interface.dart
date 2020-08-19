abstract class DatabaseInterface {
  Future<List<Map<String, dynamic>>> getAllTableData(String tableName);
  void getDataByid();
  Future<int> removeDataById(String tableName, String id);
  Future<int> dropTable(String tableName);
  Future<int> insertData(String tableName, Map<String, dynamic> data);
  Future<void> createTableIfNotExists(String tableName, String builderString);
  Future<int> updateData(String tableName, String id, Map<String, dynamic> data);
}