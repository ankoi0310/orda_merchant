extension StringExtension on String {
  bool get isInt => int.tryParse(this) != null;

  bool get isEmail => RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(this);

  bool get isValidUuid {
    final regex = RegExp(
      '^[0-9a-fA-F]{8}-'
      '[0-9a-fA-F]{4}-'
      '[0-9a-fA-F]{4}-'
      '[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(this);
  }
}
