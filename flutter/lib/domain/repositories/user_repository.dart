import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/domain/refs/user_ref.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/domain/repositories/movement_repository.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';

class UserRepository {
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();

  Future<UserEntity> getUserById(String id) async {
    final InvitationRepository invitationRepository = GetIt.I<InvitationRepository>();
    final MovementRepository movementRepository = GetIt.I<MovementRepository>();
    final PaymentRepository paymentRepository = GetIt.I<PaymentRepository>();
    final PropertyRepository propertyRepository = GetIt.I<PropertyRepository>();

    final model = await _userDataSource.getUserById(id);

    final invitations = await invitationRepository.getInvitationsByUserId(id);
    final movements = await movementRepository.getMovementsByUserId(id);
    final payments = await paymentRepository.getPaymentsByUserId(id);
    final properties = await propertyRepository.getPropertiesByUserId(id);

    final entity = UserEntity(
      id: model.id,
      createdAt: model.createdAt,
      name: model.name,
      phoneNumber: model.phoneNumber,
      emergencyPhoneNumber: model.emergencyPhoneNumber,
      email: model.email,
      invitations: invitations,
      movements: movements,
      payments: payments,
      properties: properties
    );

    return entity;
  }

  Future<UserRef> getUserRefById(String id) async {
    final user = await _userDataSource.getUserById(id);
    return UserRef(id: user.id, name: user.name);
  }
}
