extension StringExtensions on String { 
  String capitalize() { 
    return "${this[0].toUpperCase()}${substring(1)}"; 
  }

  String refValueToCamelCase(){
    String value = replaceAll(RegExp(r'[_|\s|\W]'), '');
    return value.replaceFirst(value[0], value[0].toLowerCase());
  }
} 