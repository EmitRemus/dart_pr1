class NumberParser {
  static double parse(String value) {
    return double.parse(value.replaceAll(',', '.').trim());
  }

  static double? tryParse(String value) {
    return double.tryParse(value.replaceAll(',', '.').trim());
  }
}