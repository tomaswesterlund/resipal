extension IdFormatter on String {
  String toShortId() {
    if (isEmpty) return '';
    if (length < 8) return '#$this';
    return '#${substring(0, 7)}';
  }
}
