import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/domain/use_cases/get_signed_in_user.dart';

class RegisterPayment {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  Future call({
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) async {
    final user = GetSignedInUser().call();

    await _source.registerPayment(
      communityId: user.community.id,
      userId: user.id,
      amountInCents: amountInCents,
      date: date,
      reference: reference,
      note: note,
      receiptPath: receiptPath,
    );
  }
}
