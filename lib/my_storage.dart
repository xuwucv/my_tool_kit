import 'package:shared_preferences/shared_preferences.dart';

//用于永久储存
class MyStorage {
  static final MyStorage _instance = MyStorage._internal();
  factory MyStorage() => _instance;
  late final SharedPreferences _prefs;

  MyStorage._internal();

  /// 初始化 SharedPreferences 实例
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 设置字符串
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      // 可以做一些日志记录或者抛出异常
      return Future.value(false);
    }
  }

  /// 设置布尔值
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      return Future.value(false);
    }
  }

  /// 设置字符串列表
  Future<bool> setList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      return Future.value(false);
    }
  }

  /// 设置整数
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      return Future.value(false);
    }
  }

  /// 获取字符串
  Future<String> getString(String key) async {
    return _prefs.getString(key) ?? '';
  }

  /// 获取布尔值
  Future<bool> getBool(String key) async {
    return _prefs.getBool(key) ?? false;
  }

  /// 获取字符串列表
  Future<List<String>> getList(String key) async {
    return _prefs.getStringList(key) ?? [];
  }

  /// 获取整数
  Future<int> getInt(String key) async {
    return _prefs.getInt(key) ?? 0;
  }

  /// 移除数据
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      return Future.value(false);
    }
  }
}
