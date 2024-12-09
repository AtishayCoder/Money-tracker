import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class FileManager {
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<bool> checkFilePresent(name) async {
    final dir = await _getFilePath();
    final file = File("$dir/$name");

    return await file.exists();
  }

  static Future<void> writeToFile(String name, String content) async {
    final path = _getFilePath();
    final file = File("$path/$name");
    // Write to file
    file.writeAsString(content);
  }

  static Future<String> readFile(String name) async {
    final dir = await _getFilePath();
    final file = File("$dir/$name");

    return file.readAsString();
  }
}
