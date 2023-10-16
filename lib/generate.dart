import 'dart:io';
import 'package:style_generate/helper/file_helper.dart';
import 'package:style_generate/helper/json_helper.dart';
import 'package:style_generate/ulti/const_variable.dart';
import 'package:style_generate/ulti/extension.dart';

class Generates {
  Future<void> execute(String jsonFolderPath, String outputDir) async {
    ///Get json files in folder
    final List<FileSystemEntity> fileSysEntities = await getFileSystemEntities(jsonFolderPath);

    if (fileSysEntities.isEmpty) {
      print('DPZ == Foundation folder empty!');
    } else {
      ///Init index file content
      String indexFileContent = '';
      if (jsonFolderPath.split('/').last != 'foundation') {
        indexFileContent = indexFileContentExportDartUi; 
      }
      indexFileContent += indexFileContentExportFoundation;

      for (final e in fileSysEntities) {
        final rawJson = await readJsonFile(e.path);
        if (rawJson == null) {
          continue;
        }

        final fileName = e.path.split("/").last.split('.').first;

        indexFileContent += "export '$fileName.dart';\n";

        final fileContent = _generateFileContent(rawJson);
        final outputPath = '$outputDir/${fileName.toLowerCase()}.dart';
        createFileWithContent(outputPath: outputPath, content: fileContent);
      }

      //Create File: Index.dart
      createFileWithContent(outputPath: '$outputDir/index.dart', content: indexFileContent);
    }
  }

  ///====================================================================================================///

  ///Prepare file content
  String _generateFileContent(Map<String, dynamic> jsonData) {
    //Begin
    String fileContent = '';

    //File Import
    fileContent += fileContentImportIndexFile;

    jsonData.forEach((key, value) {
      String componentName = key.toString().refValueToCamelCase();
      fileContent += '${_mapJsonComponent(componentName, value)}\n';
    });
    //End
    return fileContent;
  }

  ///Json Component
  ///Map json to dart code
  String _mapJsonComponent(String componentName, Map<String, dynamic> value) {
    String result = '';
    final rawValue = value[r'$value'];
    final rawType = value[r'$type'];

    if (rawValue == null) {
      value.forEach((key, value) {
        var name = componentName + key.toString().replaceAll(RegExp(componentNameRegex), '');
        result += _mapJsonComponent(name, value);
      });
    } else {
      switch (rawType) {
        case 'color':
          result += handleValueTypeColor(componentName, rawValue, constAccessModifier);
          break;
        case 'number':
          result += handleValueTypeNumber(componentName, rawValue, constAccessModifier);
          break;
        default:
          result += '$tabChar$staticConstAccessModifier $componentName = \'$rawValue\';\n';
          break;
      }
    }
    return result;
  }
}
