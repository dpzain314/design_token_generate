import 'dart:io';

Future<List<FileSystemEntity>> getFileSystemEntities(String folderPath) async {
  final inputDir = Directory(folderPath);
  return await inputDir.list().toList();
}

Future<void> createFileWithContent({required String outputPath, required String content}) async {
  // final indexPath = '$root/index.dart';
  final file = await createFile(outputPath);
  writeFile(file, content);
}

Future<File> createFile(String filePath) async {
  final file = File(filePath);
  final isExists = await file.exists();
  if (isExists) {
    await file.delete();
  }
  return file.create(recursive: true);
}

void writeFile(File file, String content) {
  try {
    var sink = file.openWrite();
    sink.write(content);
    sink.close();
  } catch (e) {
    print('\x1B[31m<DPZ> Error =writeFile=$e\x1B[0m');
  }
}
