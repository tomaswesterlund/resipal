import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/payment_model.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/domain/repositories/user_repository.dart';

class PaymentRepository {
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();

  Stream<PaymentEntity> watchPaymentById(String id) {
    return _paymentDataSource
        .watchPaymentById(id)
        .asyncMap((model) => _toEntity(model));
  }

  Future<PaymentEntity> getPaymentById(String id) async {
    final model = await _paymentDataSource.getPaymentById(id);
    final entity = _toEntity(model);
    return entity;
  }

  Future<List<PaymentEntity>> getPaymentsByUserId(String userId) async {
    final models = await _paymentDataSource.getPaymentsByUserId(userId);
    final futures = models.map((m) async => _toEntity(m));
    final entities = Future.wait(futures);
    return entities;
  }

  Future registerNewPayment({
    required String userId,
    required int amountInCents,
    required DateTime date,
    required String? reference,
    required String? note,
    required String receiptPath,
  }) => _paymentDataSource.registerNewPayment(
    userId: userId,
    amountInCents: amountInCents,
    date: date,
    reference: reference,
    note: note,
    receiptPath: receiptPath,
  );

  Future<PaymentEntity> _toEntity(PaymentModel model) async {
    final UserRepository userRepository = GetIt.I<UserRepository>();

    return PaymentEntity(
      id: model.id,
      user: await userRepository.getUserRefById(model.userId),
      createdAt: model.createdAt,
      amountInCents: model.amountInCents,
      status: PaymentStatus.fromString(model.status),
      date: model.date,
      reference: model.reference,
      note: model.note,
      receiptPath: model.receiptPath,
    );
  }

  Future approvePayment({
    required String userId,
    required String paymentId,
  }) async =>
      _paymentDataSource.approvePayment(userId: userId, paymentId: paymentId);
}
