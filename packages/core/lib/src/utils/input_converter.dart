class InputConverter {
  int? stringToUnsignedInteger(String str) {
    final value = int.tryParse(str);
    if (value == null || value < 0) return null;
    return value;
  }
}
