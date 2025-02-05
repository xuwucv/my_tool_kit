import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends GetxService {
  Locale locale = const Locale('en', 'US');
  static LanguageService get to => Get.find<LanguageService>();
  @override
  void onInit() async {
    super.onInit();
    // 执行一些同步的初始化操作
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
  Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
  }

  // 切换语言
  Future<void> changeLanguage(String langCode) async {
    await saveLanguage(langCode);
    Get.updateLocale(Locale(langCode.split('_')[0], langCode.split('_')[1]));
  }
}
