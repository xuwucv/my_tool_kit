import 'package:shared_preferences/shared_preferences.dart';

class MyStorage {
  static final MyStorage _instance = MyStorage._internal();
  factory MyStorage() => _instance;
  static late final SharedPreferences _prefs;

  MyStorage._internal();

  /// 初始化 SharedPreferences 实例
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 获取值，根据类型自动判断
  static Future<dynamic> getValue(String key) async {
    try {
      if (_prefs.containsKey(key)) {
        // 检查具体值的类型并返回
        var value = _prefs.get(key);
        return value;
      }
      return null; // 如果 key 不存在，返回 null
    } catch (e) {
      return null; // 捕获错误并返回 null
    }
  }

  /// 设置值，根据类型自动判断
  static Future<bool> setValue(String key, dynamic value) async {
    try {
      if (value is String) {
        return await _prefs.setString(key, value);
      } else if (value is bool) {
        return await _prefs.setBool(key, value);
      } else if (value is List<String>) {
        return await _prefs.setStringList(key, value);
      } else if (value is int) {
        return await _prefs.setInt(key, value);
      } else {
        throw ArgumentError('Unsupported value type');
      }
    } catch (e) {
      return Future.value(false);
    }
  }

  /// 移除数据
  static Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      return Future.value(false);
    }
  }

  /// 判断 key 是否存在
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
