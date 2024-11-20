// lib/print_helper.dart

class MyPrint {
  // 私有静态变量存储唯一实例1
  static final MyPrint _instance = MyPrint._internal();

  // 工厂构造函数返回实例
  factory MyPrint() => _instance;

  // 私有构造函数
  MyPrint._internal();

  // 默认为开启日志
  bool _isLoggingEnabled = true;

  /// 初始化方法，可以进行日志相关的配置
  void init({bool isLoggingEnabled = true}) {
    _isLoggingEnabled = isLoggingEnabled;
  }

  /// 设置日志开关
  void setLoggingEnabled(bool isEnabled) {
    _isLoggingEnabled = isEnabled;
  }

  /// 打印普通日志
  void log(String message) {
    if (_isLoggingEnabled) {
      print("MYPrint(0.0): $message");
    }
  }

  /// 打印调试日志，只有在调试模式下才显示
  void debug(String message) {
    if (_isLoggingEnabled) {
      assert(() {
        print("DEBUG: $message");
        return true;
      }());
    }
  }

  /// 打印警告日志
  void warn(String message) {
    if (_isLoggingEnabled) {
      print("WARNING: $message");
    }
  }

  /// 打印错误日志
  void error(String message) {
    if (_isLoggingEnabled) {
      print("ERROR: $message");
    }
  }

  /// 打印带时间戳的日志
  void logWithTime(String message) {
    if (_isLoggingEnabled) {
      final timeStamp = DateTime.now().toIso8601String();
      print("[$timeStamp] LOG: $message");
    }
  }

  /// 打印带颜色的日志
  void logWithColor(String message, {String color = 'green'}) {
    if (_isLoggingEnabled) {
      String coloredMessage = _getColoredMessage(message, color);
      print(coloredMessage);
    }
  }

  // 私有方法，用于根据颜色参数返回带颜色的日志
  String _getColoredMessage(String message, String color) {
    const colorCodes = {
      'green': '\x1B[32m',
      'yellow': '\x1B[33m',
      'red': '\x1B[31m',
      'blue': '\x1B[34m',
      'reset': '\x1B[0m'
    };

    final colorCode = colorCodes[color] ?? colorCodes['reset'];
    return '$colorCode$message\x1B[0m';
  }
}
