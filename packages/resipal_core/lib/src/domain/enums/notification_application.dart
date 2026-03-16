enum NotificationApplication {
  admin,
  resident,
  security;

  static NotificationApplication fromString(String value) {
    return switch (value) {
      'admin' => NotificationApplication.admin,
      'resident' => NotificationApplication.resident,
      'security' => NotificationApplication.security,
      _ => throw UnimplementedError(),
    };
  }
}
