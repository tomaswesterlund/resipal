enum DirectionType {
  entry,
  exit,
  unkown;

  static DirectionType fromString(String value) {
    if (value.toLowerCase().trim() == 'entry') return DirectionType.entry;
    if (value.toLowerCase().trim() == 'exit') return DirectionType.exit;
    return DirectionType.unkown;
  }
}