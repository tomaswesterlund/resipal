class RegisterPayment {
  Future call(RegisterPaymentCommand command) async {}
}

class RegisterPaymentCommand {
  final String userId;
  final int amountInCents;
  final DateTime date;
  final String reference;
  final String note;
  final String receiptPath;

  RegisterPaymentCommand({
    required this.userId,
    required this.amountInCents,
    required this.date,
    required this.reference,
    required this.note,
    required this.receiptPath,
  });
}
