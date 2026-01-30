import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/invitation_model.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/repositories/access_log_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';
import 'package:rxdart/streams.dart';

class InvitationRepository {
  final InvitationDataSource _invitationDataSource = GetIt.I<InvitationDataSource>();

  final Map<String, InvitationEntity> _cache = {};
  late final Stream<List<InvitationEntity>> _stream;

  InvitationRepository() {
    _stream = _invitationDataSource
        .watchInvitations()
        .asyncMap((models) => _processAndCache(models))
        .shareValue(); // Shares the latest value with all new listeners
  }

  Stream<List<InvitationEntity>> watchInvitations() => _stream;

  Stream<List<InvitationEntity>> watchInvitationsByUserId(String userId) {
    return _stream
        .map((list) => list.where((invitation) => invitation.user.id == userId).toList())
        .distinct(); // Only emits if the filtered list actually changes
  }

  Stream<List<InvitationEntity>> watchActiveInvitationsByUserId(String userId) {
    return _stream
        .map((list) => list.where((invitation) => invitation.user.id == userId && invitation.isActive).toList())
        .distinct(); // Only emits if the filtered list actually changes
  }

  Stream<InvitationEntity> watchMovementById(String id) {
    return _stream
        .expand((list) => list) // Turn list into individual items
        .where((movement) => movement.id == id)
        .distinct();
  }

  List<InvitationEntity> getInvitationsByUserId(String userId) => _cache.values.where((e) => e.user.id == userId).toList();

  List<InvitationEntity> getActiveInvitationsByUserId(String userId) => _cache.values.where((e) => e.user.id == userId && e.isActive).toList();

  Future<InvitationEntity> _toEntity(InvitationModel model) async {
    final accessLogRepository = GetIt.I<AccessLogRepository>();
    final propertyRepository = GetIt.I<PropertyRepository>();
    final userRepository = GetIt.I<UserRepository>();
    final visitorRepository = GetIt.I<VisitorRepository>();

    final entity = InvitationEntity(
      id: model.id,
      user: await userRepository.getUserRefById(model.userId),
      property: propertyRepository.getPropertyRefById(model.propertyId),
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
  }) async => _invitationDataSource.createInvitation(userId: userId, propertyId: propertyId, visitorId: visitorId, fromDate: fromDate, toDate: toDate);

  Future<List<InvitationEntity>> _processAndCache(List<InvitationModel> models) async {
    return Future.wait(
      models.map((model) async {
        // If we already processed this exact version, return from cache
        // (Note: You might need a version/updated_at check if data can change)
        if (_cache.containsKey(model.id)) {
          return _cache[model.id]!;
        }

        final entity = await _toEntity(model);
        _cache[model.id] = entity;
        return entity;
      }),
    );
  }
}
