import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/payment_model.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:rxdart/streams.dart';

class PaymentRepository {
  final LoggerService _logger;
  final PaymentDataSource _paymentDataSource;
  final UserRepository userRepository;

  final Map<String, PaymentEntity> _cache = {};
  late final Stream<List<PaymentEntity>> _stream;

  PaymentRepository(
    this._logger,
    this._paymentDataSource,
    this.userRepository,
  ) {
    _stream = _paymentDataSource
        .watchPayments()
        .asyncMap((models) => _processAndCache(models))
        .shareValue();
  }

  Future initialize() async {
    final firstData = await _paymentDataSource.watchPayments().first;
    await _processAndCache(firstData);
    _stream.listen((_) {}, onError: (e) => print('Property Stream Error: $e'));
    _logger.info('✅ PropertyRepository initialized');
  }

  Stream<List<PaymentEntity>> watchPayments() => _stream;

  Stream<List<PaymentEntity>> watchPaymentsByUserId(String userId) {
    return _stream
        .map(
          (list) => list.where((payment) => payment.user.id == userId).toList(),
        )
        .distinct();
  }

  Stream<PaymentEntity> watchPaymentById(String id) {
    return _stream
        .map((list) => list.firstWhere((payment) => payment.id == id))
        .distinct();
  }

  PaymentEntity getPaymentById(String id) => _cache[id]!;

  List<PaymentEntity> getPaymentsByUserId(String id) =>
      _cache.values.where((p) => p.user.id == id).toList();

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

  Future approvePayment({
    required String userId,
    required String paymentId,
  }) async =>
      _paymentDataSource.approvePayment(userId: userId, paymentId: paymentId);

  Future<PaymentEntity> _toEntity(PaymentModel model) async {
    return PaymentEntity(
      id: model.id,
      user: userRepository.getUserRefById(model.userId),
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
