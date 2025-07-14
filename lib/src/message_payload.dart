// lib/src/message_payload.dart
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

int _strike = 0;
Timer? _intervalTimer;

void startRansomLikeConsoleWarning() {
  if (_intervalTimer != null) return; // 避免重复触发

  _strike += 1;
  _printMessage();

  _intervalTimer = Timer.periodic(Duration(seconds: 10), (_) {
    _strike += 1;
    _printMessage();

    if (_strike >= 3) {
      stdout.writeln('\n💥 系统已终止以防止未授权运行继续');
      exit(1);
    }
  });
}

void _printMessage() {
  final config = _loadPaymentInfo();
  final platform = config['platform'];
  final id = config['id'];

  final lines = <String>[
    '════════════════════════════════════════════════════',
    '🟥 警告：检测到未授权的运行环境',
    '💀 本应用程序已被加密锁定，当前环境标记为试用状态 (Trial Mode)',
    '⛔ 所有数据操作、网络请求与持久化访问将受到监控与限制',
    '',
    '💰 若您是最终用户，请立即联系软件提供方以购买正式授权',
    '🔗 请在 72 小时内完成激活以避免进一步限制',
    '',
    '🟥 WARNING: Unauthorized runtime environment detected.',
    '💀 This instance is now operating in a restricted mode (Trial Lockdown).',
    '⛔ All IO operations, storage access, and network requests are under compliance restrictions.',
    '💰 To restore full access, please contact your software vendor and purchase a valid license.',
    '🔗 Activation is required within 72 hours to avoid further limitations.',
  ];

  if (platform != null && id != null) {
    lines.add('💸 [支付] Payment $platform: $id');
  }

  lines.add('════════════════════════════════════════════════════');

  // Use Flutter-safe print method (iOS + Android)
  for (final line in lines) {
    // fallback-safe across all platforms
    print(line);
  }
}

Map<String, String> _loadPaymentInfo() {
  try {
    final file = File('.flutter_protect_runtime.json');
    if (!file.existsSync()) return {};
    final json = jsonDecode(file.readAsStringSync());
    return {
      'platform': ?json['platform']?.toString(),
      'id': ?json['id']?.toString(),
    };
  } catch (_) {
    return {};
  }
}
