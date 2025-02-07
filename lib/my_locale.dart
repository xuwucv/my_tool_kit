import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language {
  /// 英文（美国）
  en_US,

  /// 中文（中国）
  zh_CN,

  /// 日语（日本）
  ja_JP,

  /// 法语（法国）
  fr_FR;

  /// 从字符串解析 `Language`
  static Language fromCode(String code) {
    // 先尝试完整匹配
    final match = Language.values.firstWhere(
      (lang) => lang.name == code,
      orElse: () {
        // 如果找不到完整匹配，就尝试匹配语言代码（zh、en等）
        return Language.values.firstWhere(
          (lang) => lang.name.startsWith(code),
          orElse: () => Language.en_US, // 默认返回英文
        );
      },
    );
    return match;
  }

  /// 转换为 `Locale`
  Locale toLocale() {
    final parts = name.split('_');
    return Locale(parts[0], parts[1]);
  }
}

class LanguageService extends GetxService {
  late Locale locale; // 使用 late 声明，表示稍后会初始化
  static LanguageService get to => Get.find<LanguageService>();

  Future<void> initialize() async {
    locale = await getCurrentLanguage();
  }

  // 获取当前语言
  Future<Locale> getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    // 获取系统默认语言
    Locale systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (prefs.getString('language_code') == null) {
      return systemLocale;
    }
    String langCode = prefs.getString('language_code') ?? 'en_US'; // 默认返回 en_US
    return Locale(langCode.split('_')[0], langCode.split('_')[1]);
  }

  // 保存语言
  Future<void> saveLanguage({required Language langCode}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode.name);
  }

  // 切换语言
  Future<void> changeLanguage({required Language langCode}) async {
    await saveLanguage(langCode: langCode);
    Get.updateLocale(langCode.toLocale());
  }
}
