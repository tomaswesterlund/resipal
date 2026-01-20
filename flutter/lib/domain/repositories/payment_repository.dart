import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/domain/entities/payment_entity.dart';
import 'package:resipal/domain/enums/payment_status.dart';
import 'package:resipal/domain/repositories/user_repository.dart';

class PaymentRepository {
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  
  Future<List<PaymentEntity>> getPaymentsByUserId(String userId) async {
    final UserRepository userRepository = GetIt.I<UserRepository>();

    final models = await _paymentDataSource.getPaymentsByUserId(userId);
    final futures = models.map(
      (m) async => PaymentEntity(
        id: m.id,
        user: await userRepository.getUserRefById(m.userId),
        createdAt: m.createdAt,
        amountInCents: m.amountInCents,
        status: PaymentStatus.fromString(m.status),
        date: m.date,
        reference: m.reference,
        note: m.note,
      ),
    );

    final entities = Future.wait(futures);
    return entities;
  }
}
