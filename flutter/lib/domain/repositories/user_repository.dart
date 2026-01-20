import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/domain/entities/refs/user_ref.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/repositories/movement_repository.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';

class UserRepository {
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();
  final MovementRepository _movementRepository = GetIt.I<MovementRepository>();
  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();

  Future<UserEntity> getUserById(String id) async {
    final model = await _userDataSource.getUserById(id);
    final movements = await _movementRepository.getMovementsByUserId(id);
    final payments = await _paymentRepository.getPaymentsByUserId(id);

    final entity = UserEntity(
      id: model.id,
      createdAt: model.createdAt,
      name: model.name,
      phoneNumber: model.phoneNumber,
      emergencyPhoneNumber: model.emergencyPhoneNumber,
      email: model.email,
      movements: movements,
      payments: payments,
    );

    return entity;
  }

  Future<UserRef> getUserRefById(String id) async {
    final user = await _userDataSource.getUserById(id);
    return UserRef(id: user.id, name: user.name);
  }
}
