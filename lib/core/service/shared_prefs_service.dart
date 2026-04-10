import 'dart:convert';

import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SharedPrefsService {
  Future<void> setString(String key, String value);

  Future<String?> getString(String key);

  Future<void> setBool(String key, bool value);

  Future<bool?> getBool(String key);

  Future<void> setInt(String key, int value);

  Future<int?> getInt(String key);

  Future<void> remove(String key);

  Future<void> clear();

  Future<void> setObject(String key, JsonData value);

  Future<T?> getObject<T>(String key, T Function(JsonData) fromJson);

  Future<void> setObjectList(String key, List<JsonData> value);

  Future<List<T>?> getObjectList<T>(
    String key,
    T Function(JsonData) fromJson,
  );
}

class SharedPrefsServiceImpl implements SharedPrefsService {
  SharedPrefsServiceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }

  @override
  Future<void> setObject(String key, JsonData value) async {
    final jsonString = jsonEncode(value);
    await _prefs.setString(key, jsonString);
  }

  @override
  Future<T?> getObject<T>(
    String key,
    T Function(JsonData) fromJson,
  ) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    final decoded = jsonDecode(jsonString) as JsonData;
    return fromJson(decoded);
  }

  @override
  Future<void> setObjectList(String key, List<JsonData> value) async {
    final jsonString = jsonEncode(value);
    await _prefs.setString(key, jsonString);
  }

  @override
  Future<List<T>?> getObjectList<T>(
    String key,
    T Function(JsonData) fromJson,
  ) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    final decoded = jsonDecode(jsonString) as List<JsonData>;

    return decoded.map((e) => fromJson(JsonData.from(e))).toList();
  }
}
