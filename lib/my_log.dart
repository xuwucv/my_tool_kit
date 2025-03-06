import 'package:flutter/foundation.dart';

/// 日志等级
enum LogLevel { verbose, debug, info, warning, error }

class MyLog {
  // 私有构造函数
  MyLog._internal();

  // 单例实例
  static final MyLog _instance = MyLog._internal();

  // 获取单例实例
  static MyLog get instance => _instance;

  /// 是否启用日志
  static bool isEnabled = true;

  /// 当前日志等级
  static LogLevel logLevel = LogLevel.verbose;

  /// 初始化日志设置
  static void initialize(
      {bool enableLogs = true, LogLevel level = LogLevel.verbose}) {
    isEnabled = enableLogs;
    logLevel = level;
  }

  /// 打印日志
  static void log(dynamic message,
      {LogLevel level = LogLevel.debug, String? tag}) {
    // 在正式版时禁用日志
    if (!kDebugMode) return; // 在 Release 或 Profile 模式下不打印日志

    if (!isEnabled) return; // 日志功能被禁用

    // 日志等级过滤
    if (level.index < logLevel.index) return;

    // 格式化日志输出
    final timestamp = DateTime.now().toIso8601String();
    final logTag = tag != null ? "[$tag]" : "";
    final logLevelName = level.name.toUpperCase();

    debugPrint("$timestamp $logLevelName $logTag: $message");
  }

  /// 打印详细信息日志
  static void v(dynamic message, {String? tag}) {
    log(message, level: LogLevel.verbose, tag: tag);
  }

  /// 打印调试日志
  static void d(dynamic message, {String? tag}) {
    log(message, level: LogLevel.debug, tag: tag);
  }

  /// 打印信息日志
  static void i(dynamic message, {String? tag}) {
    log(message, level: LogLevel.info, tag: tag);
  }

  /// 打印警告日志
  static void w(dynamic message, {String? tag}) {
    log(message, level: LogLevel.warning, tag: tag);
  }

  /// 打印错误日志
  static void e(dynamic message, {String? tag}) {
    log(message, level: LogLevel.error, tag: tag);
  }
}
