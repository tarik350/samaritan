import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFileForCounter async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

Future<File> get _localFileForMedicineSaved async {
  final path = await _localPath;
  return File('$path/medicines.txt');
}

//if i want to read counter i pass in string flag called counter or
//if i want to read medine i pass string flag medicine

Future<int> readCounter(String flag) async {
  try {
    final file = flag == 'counter'
        ? await _localFileForCounter
        : await _localFileForMedicineSaved;

    // Read the file
    final contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}

Future<File> writeCounter(int medCount, String flag) async {
  final file = flag == 'counter'
      ? await _localFileForCounter
      : await _localFileForMedicineSaved;

  // Write the file
  return file.writeAsString('$medCount');
}
