import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  /// 显示一个 Toast 提示
  ///
  /// [msg] 为提示信息，
  /// [gravity] 为显示位置，默认为居中（ToastGravity.CENTER），
  /// [backgroundColor] 为背景颜色，默认为红色，
  /// [textColor] 为文字颜色，默认为白色，
  /// [fontSize] 为文字大小，默认为16，
  /// [toastLength] 为显示时长，默认为短暂显示（Toast.LENGTH_SHORT），
  /// [timeInSecForIosWeb] 为 iOS 或 Web 平台显示时间（秒），默认为1秒。
  static void showToast(
    String msg, {
    ToastGravity gravity = ToastGravity.CENTER,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    double fontSize = 16.0,
    Toast toastLength = Toast.LENGTH_SHORT,
    int timeInSecForIosWeb = 1,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
