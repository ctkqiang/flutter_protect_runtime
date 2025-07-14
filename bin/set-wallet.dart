// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final argMap = _parseArgs(args);

  final platform = argMap['--platform'];
  final id = argMap['--id'];

  if (argMap.containsKey('--help') || argMap.containsKey('-h')) {
    _printUsage();
    exit(0);
  }

  if (platform == null || id == null) {
    stderr.writeln('❌ 缺少必要参数: --platform 与 --id');
    _printUsage();
    exit(1);
  }

  final config = {
    'platform': platform.trim(),
    'id': id.trim(),
    'updated_at': DateTime.now().toIso8601String(),
  };

  final file = File('.flutter_protect_runtime.json');
  file.writeAsStringSync(jsonEncode(config), flush: true);

  print('✅ 钱包配置已保存');
  print('🔗 平台: $platform');
  print('🧾 钱包 ID: $id');
  print('📁 存储路径: ${file.absolute.path}');
}

Map<String, String> _parseArgs(List<String> args) {
  final result = <String, String>{};
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg.startsWith('--') &&
        i + 1 < args.length &&
        !args[i + 1].startsWith('--')) {
      result[arg] = args[i + 1];
      i++;
    } else if (arg.startsWith('--') || arg.startsWith('-')) {
      result[arg] = 'true';
    }
  }
  return result;
}

void _printUsage() {
  print('''

Flutter Protect Runtime Wallet Setup
────────────────────────────────────

用法:
  dart run flutter_protect_runtime:set-wallet --platform tron --id T666XYZ

参数:
  --platform   钱包平台，如 tron, usdt, eth
  --id         钱包地址
  --help       显示帮助信息

示例:
  dart run flutter_protect_runtime:set-wallet --platform usdt --id T999QQQ

''');
}
