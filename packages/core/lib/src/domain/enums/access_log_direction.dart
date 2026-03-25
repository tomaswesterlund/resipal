enum AccessLogDirection {
  entry,
  exit;

  @override
  String toString() {
    return switch (this) {
      AccessLogDirection.entry => 'entry',
      AccessLogDirection.exit => 'exit',
    };
  }

  static AccessLogDirection fromString(String value) {
    return switch (value) {
      'entry' => AccessLogDirection.entry,
      'exit' => AccessLogDirection.exit,

      _ => throw Exception('AccessLogDirection.fromString() cant map value: $value'),
    };
  }
}
