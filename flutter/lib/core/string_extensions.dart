extension NullableStringExt on String? {
  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;
}