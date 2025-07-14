import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

void main(List<String> args) {
  final argMap = _parseArgs(args);
  final platform = argMap['--platform'];
  final id = argMap['--id'];

  if (platform == null || id == null) {
    if (kDebugMode) {
      print('[!] Missing required --platform or --id.');
    }
    exit(1);
  }

  final config = {'platform': platform, 'id': id};

  final file = File('.flutter_protect_runtime.json');
  file.writeAsStringSync(jsonEncode(config), flush: true);

  if (kDebugMode) {
    print('[✓] Payment info saved: $platform: $id');
  }
}

Map<String, String> _parseArgs(List<String> args) {
  final result = <String, String>{};
  for (var i = 0; i < args.length; i++) {
    if (args[i].startsWith('--') && i + 1 < args.length) {
      result[args[i]] = args[i + 1];
      i++;
    }
  }
  return result;
}
