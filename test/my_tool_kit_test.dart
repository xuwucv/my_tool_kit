import 'package:flutter_test/flutter_test.dart';
import 'package:my_tool_kit/my_print.dart';

void main() {
  test('adds one to input values', () {
    Log.init(isEnabled: true);

    // 使用日志
    Log.d("This is a debug message");
  });
}
