//Load json file
import 'dart:convert';
import 'dart:io';
import 'package:style_generate/ulti/extension.dart';

import '../ulti/const_variable.dart';

Future<Map<String, dynamic>?> readJsonFile(String path) async {
  try {
    var input = await File(path).readAsString();
    return jsonDecode(input);
  } catch (e) {
    print('\x1B[31m<DPZ> Path: $path\x1B[0m');
    print('\x1B[31m<DPZ> Error =readJsonFile= Read json file - $e\x1B[0m');
    return null;
  }
}

///******************************* Handle data type */
String handleValueTypeColor(String componentName, String rawValue, String accessModifier) {
  if (RegExp(componentColorRegex).hasMatch(rawValue)) {
    // Color(0xFF4BAC4D);
    final colorCode = rawValue.replaceAll('#', '0xFF');
    return '$accessModifier $componentName = Color($colorCode);\n';
  } else if (rawValue.startsWith('rgba')) {
    // Color.fromRGBO(255, 179, 102, 1)
    final colorCode = rawValue.replaceAll('rgba', 'Color.fromRGBO');
    return '$accessModifier $componentName = $colorCode;\n';
  } else if (rawValue.startsWith('{')) {
    //'{Color.Palette.Blue.50}';
    return '$accessModifier $componentName = ${rawValue.refValueToCamelCase()};\n';
  }
  return 'accessModifier $componentName = \'$rawValue\';\n';
}

String handleValueTypeNumber(String componentName, dynamic rawValue, String accessModifier) {
  if (rawValue is num) {
    return '$accessModifier $componentName = $rawValue;\n';
  } else if (rawValue.startsWith('{')) {
    //'{Text.Paragraph Spacing.Auto}';
    return '$accessModifier $componentName = ${(rawValue as String).refValueToCamelCase()};\n';
  }
  return '$accessModifier $componentName = \'$rawValue\';\n';
}
