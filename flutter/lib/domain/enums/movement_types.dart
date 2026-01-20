enum MovementTypes {
  maintenanceFee,
  extraordinaryFee,
  fine,
  payment,
  other,
  unknown;

  static MovementTypes fromString(String value) {
    return switch (value) {
      'maintenance_fee' => MovementTypes.maintenanceFee,
      'extra_ordinary_fee' => MovementTypes.extraordinaryFee,
      'fine' => MovementTypes.fine,
      'payment' => MovementTypes.payment,
      'other' => MovementTypes.other,
      _ => MovementTypes.unknown,
    };
  }
}
