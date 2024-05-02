abstract class LocalStorageService {
  Future<bool> saveData(String key, dynamic data);
  Object? getData(String key);
  double? getDouble(String key);
  Future<bool> setDouble(String key, double value);
  Future<bool> deleteData(String key);
  List<String>? getListString(String key);
  Future<bool> setListString(String key, List<String> value);
  List<String> getAllKeys();
}
