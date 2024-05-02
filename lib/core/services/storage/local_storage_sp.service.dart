import 'package:shelve/core/services/storage/local_storage.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSPService extends LocalStorageService {
  final SharedPreferences _sharedPreferences;

  LocalStorageSPService(this._sharedPreferences);

  @override
  Future<bool> deleteData(String key) async {
    return _sharedPreferences.remove(key);
  }

  @override
  Future<Object?> getData(String key) async {
    return _sharedPreferences.get(key);
  }

  @override
  Future<bool> saveData(String key, data) async {
    if (data is String) {
      return _sharedPreferences.setString(key, data);
    } else if (data is int) {
      return _sharedPreferences.setInt(key, data);
    } else if (data is double) {
      return _sharedPreferences.setDouble(key, data);
    } else if (data is bool) {
      return _sharedPreferences.setBool(key, data);
    } else if (data is List<String>) {
      return _sharedPreferences.setStringList(key, data);
    }

    return false;
  }

  @override
  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  @override
  Future<bool> setDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  @override
  List<String>? getListString(String key) {
    return _sharedPreferences.getStringList(key);
  }

  @override
  Future<bool> setListString(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  @override
  List<String> getAllKeys() {
    return _sharedPreferences.getKeys().toList();
  }
}
