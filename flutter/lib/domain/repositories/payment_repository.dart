import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/payment_model.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';

class PaymentRepository {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();

  final Map<String, PaymentEntity> _cache = {};

  Future initialize() async {
    final firstData = await _paymentDataSource.watchPayments().first;
    await _processAndCache(firstData);
    _logger.info('✅ PaymentRepository initialized');
  }

  PaymentEntity getPaymentById(String id) => _cache[id]!;

  List<PaymentEntity> getPaymentsByUserId(String userId) => _cache.values.where((p) => p.userId == userId).toList();

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

  Future approvePayment({required String userId, required String paymentId}) async =>
      _paymentDataSource.approvePayment(userId: userId, paymentId: paymentId);

  Future<PaymentEntity> _toEntity(PaymentModel model) async {
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

  Future<List<PaymentEntity>> _processAndCache(List<PaymentModel> models) {
    return Future.wait(
      models.map((model) async {
        if (_cache.containsKey(model.id)) {
          final current = _cache[model.id];
          final updated = await _toEntity(model);

          if (current != updated) {
            _cache[model.id] = updated;
          }

          return _cache[model.id]!;
        } else {
          final entity = await _toEntity(model);
          _cache[model.id] = entity;
          return entity;
        }
      }),
    );
  }
}
