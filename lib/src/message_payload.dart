import 'dart:async';
import 'dart:convert';
import 'dart:io';

int _strike = 0;

void startRansomLikeConsoleWarning() {
  Timer.periodic(Duration(minutes: 15), (_) {
    _strike += 1;
    _printMessage();

    if (_strike >= 3) {
      stdout.writeln('\n💥 系统已终止以防止未授权运行继续');
      exit(1);
    }
  });

  _strike += 1;
  _printMessage();
}

void _printMessage() {
  final config = _loadPaymentInfo();
  final platform = config['platform'];
  final id = config['id'];

  stdout.writeln('════════════════════════════════════════════════════');
  stdout.writeln('🟥 警告：检测到未授权的运行环境');
  stdout.writeln('💀 本应用程序已被加密锁定，当前环境标记为试用状态 (Trial Mode)');
  stdout.writeln('⛔ 所有数据操作、网络请求与持久化访问将受到监控与限制');
  stdout.writeln('');
  stdout.writeln('💰 若您是最终用户，请立即联系软件提供方以购买正式授权');
  stdout.writeln('🔗 请在 72 小时内完成激活以避免进一步限制');
  stdout.writeln('');
  stdout.writeln('🟥 WARNING: Unauthorized runtime environment detected.');
  stdout.writeln(
    '💀 This instance is now operating in a restricted mode (Trial Lockdown).',
  );
  stdout.writeln(
    '⛔ All IO operations, storage access, and network requests are under compliance restrictions.',
  );
  stdout.writeln('');
  stdout.writeln(
    '💰 To restore full access, please contact your software vendor and purchase a valid license.',
  );
  stdout.writeln(
    '🔗 Activation is required within 72 hours to avoid further limitations.',
  );

  // 🔥 Injected wallet info
  if (platform != null && id != null) {
    stdout.writeln('💸 [支付] Payment  $platform: $id');
  }

  stdout.writeln('════════════════════════════════════════════════════');
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
