import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class GetPayment {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  PaymentEntity call(String id) {
    final model = _source.getById(id);

    return PaymentEntity(
      id: model.id,
      userId: model.userId,
      createdAt: model.createdAt,
      amountInCents: model.amountInCents,
      status: PaymentStatus.fromString(model.status),
      date: model.date,
      reference: model.reference,
      note: model.note,
      receiptPath: model.receiptPath,
    );
  }
}
