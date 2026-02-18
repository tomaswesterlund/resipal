extension NullableStringExtensions on String? {
  bool isNotNullOrEmpty() {
    if (this == null) return false;
    if (this?.trim() == '') return false;
    return true;
  }
}
