import 'dart:io';
import 'package:path/path.dart' as path;

String readJson(String name) {
  final pathsToTry = [
    path.join('test', name),
    path.join('core', 'test', name),
  ];

  for (final possiblePath in pathsToTry) {
    final file = File(possiblePath);
    if (file.existsSync()) {
      return file.readAsStringSync();
    }
  }

  throw Exception('File not found: $name');
}