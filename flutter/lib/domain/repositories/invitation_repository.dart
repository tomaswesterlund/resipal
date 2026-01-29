import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/invitation_model.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/repositories/access_log_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';

class InvitationRepository {
  final InvitationDataSource _invitationDataSource =
      GetIt.I<InvitationDataSource>();

  Stream<List<InvitationEntity>> watchInvitationsByUserId(String userId) {
    return _invitationDataSource.watchInvitationsByUserId(userId).asyncMap((
      list,
    ) async {
      final entities = await Future.wait(list.map((i) => _toEntity(i)));
      return entities;
    });
  }

  Future<List<InvitationEntity>> getInvitationsByUserId(String userId) async {
    final models = await _invitationDataSource.getInvitationsByUserId(userId);
    final futures = models.map((model) async => _toEntity(model));
    final entities = Future.wait(futures);
    return entities;
  }

  Future<List<InvitationEntity>> getActiveInvitationsByUserId(
    String userId,
  ) async {
    final models = await _invitationDataSource.getActiveInvitationsByUserId(
      userId,
    );
    final futures = models.map((model) async => _toEntity(model));
    final entities = Future.wait(futures);
    return entities;
  }

  Future<InvitationEntity> _toEntity(InvitationModel model) async {
    final accessLogRepository = GetIt.I<AccessLogRepository>();
    final propertyRepository = GetIt.I<PropertyRepository>();
    final userRepository = GetIt.I<UserRepository>();
    final visitorRepository = GetIt.I<VisitorRepository>();

    final entity = InvitationEntity(
      id: model.id,
      user: await userRepository.getUserRefById(model.userId),
      property: await propertyRepository.getPropertyRefById(model.propertyId),
      visitor: await visitorRepository.getVisitoryRefById(model.visitorId),
      createdAt: model.createdAt,
      qrCodeToken: model.qrCodeToken,
      fromDate: model.fromDate,
      toDate: model.toDate,
      maxEntries: model.maxEntries,
      logs: await accessLogRepository.getAccessLogsByInvitationId(model.id),
    );

    return entity;
  }

  Future createInvitation({
    required String userId,
    required String propertyId,
    required String visitorId,
    required DateTime fromDate,
    required DateTime toDate,
  }) async => _invitationDataSource.createInvitation(
    userId: userId,
    propertyId: propertyId,
    visitorId: visitorId,
    fromDate: fromDate,
    toDate: toDate,
  );
}
