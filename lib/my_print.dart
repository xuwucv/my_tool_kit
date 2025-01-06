class Log {
  static final Log _instance = Log._internal(); // 单例实例

  static bool _isEnabled = true; // 是否启用日志

  /// 私有构造函数
  Log._internal();

  /// 提供一个工厂构造函数，返回同一个实例
  factory Log() {
    return _instance;
  }

  /// 初始化日志工具（可以控制是否打印日志）
  static void init({bool isEnabled = true}) {
    _isEnabled = isEnabled;
  }

  /// 打印日志（只需调用 Log.print("message")）
  static void d(String message) {
    if (_isEnabled) {
      print("[MyLog][DEBUG] $message");
    }
  }
}
