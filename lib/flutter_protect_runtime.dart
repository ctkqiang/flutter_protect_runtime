// ignore_for_file: unnecessary_library_name, unused_element

library flutter_protect_runtime;

import 'src/message_payload.dart';

/// 开发者可手动触发初始化（推荐）
void initGuard() => startRansomLikeConsoleWarning();

// 自动执行（⚠️ 只在 debug 模式有效）
final _ = (() {
  assert(() {
    startRansomLikeConsoleWarning();
    return true;
  }());
})();
