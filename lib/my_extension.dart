extension NumberFormatting on double {
  /// 格式化数字，移除小数部分的多余零
  String formatNumber() {
    return toStringAsFixed(2).replaceAll(RegExp(r'([.]*0+)$'), '');
  }
}

extension IntVoidExtension on int {
  /// 将毫秒转为 [小时:分钟:秒] 的格式
  String formatMilliseconds() {
    int totalSeconds = this ~/ 1000; // 转换为秒
    return totalSeconds.formatSeconds();
  }

  /// 将秒转为 [小时:分钟:秒] 的格式
  String formatSeconds() {
    int hours = this ~/ 3600; // 1 小时 = 3600 秒
    int minutes = (this % 3600) ~/ 60;
    int remainingSeconds = this % 60;

    // 格式化为 HH:MM:SS 或 MM:SS
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${remainingSeconds.toString().padLeft(2, '0')}';
    }
  }
}
