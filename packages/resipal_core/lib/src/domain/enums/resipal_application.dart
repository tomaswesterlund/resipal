enum ResipalApplication {
  admin,
  resident,
  security;

  @override
  String toString() {
    return switch (this) {
      ResipalApplication.admin => 'admin',
      ResipalApplication.resident => 'resident',
      ResipalApplication.security => 'security',
    };
  }

  static ResipalApplication fromString(String value) {
    return switch (value) {
      'admin' => ResipalApplication.admin,
      'resident' => ResipalApplication.resident,
      'security' => ResipalApplication.security,
      _ => throw UnimplementedError('Unknown resipal app: $value'),
    };
  }
}
