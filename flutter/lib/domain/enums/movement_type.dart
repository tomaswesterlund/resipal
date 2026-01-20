enum MovementType {
  maintenanceFee,
  extraordinaryFee,
  fine,
  payment,
  other,
  unknown;

  static MovementType fromString(String value) {
    return switch (value) {
      'maintenance_fee' => MovementType.maintenanceFee,
      'extra_ordinary_fee' => MovementType.extraordinaryFee,
      'fine' => MovementType.fine,
      'payment' => MovementType.payment,
      'other' => MovementType.other,
      _ => MovementType.unknown,
    };
  }
}
