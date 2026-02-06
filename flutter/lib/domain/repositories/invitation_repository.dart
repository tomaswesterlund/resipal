import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/invitation_model.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/repositories/access_log_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';

class InvitationRepository {
  final LoggerService _logger;
  final InvitationDataSource _invitationDataSource;
  final _accessLogRepository;
  final _propertyRepository;
  final _userRepository;
  final _visitorRepository;

  final Map<String, InvitationEntity> _cache = {};

  InvitationRepository(
    this._logger,
    this._invitationDataSource,
    this._accessLogRepository,
    this._propertyRepository,
    this._userRepository,
    this._visitorRepository,
  );

  Future initialize() async {
    final firstData = await _invitationDataSource.watchInvitations().first;
    _processAndCache(firstData);
    _logger.info('✅ PropertyRepository initialized');
  }

  List<InvitationEntity> getInvitationsByUserId(String userId) =>
      _cache.values.where((e) => e.user.id == userId).toList();

  List<InvitationEntity> getActiveInvitationsByUserId(String userId) =>
      _cache.values.where((e) => e.user.id == userId && e.isActive).toList();

  Future<InvitationEntity> _toEntity(InvitationModel model) async {
    final entity = InvitationEntity(
      id: model.id,
      user: await _userRepository.getUserRefById(model.userId),
      property: _propertyRepository.getPropertyRefById(model.propertyId),
      visitor: await _visitorRepository.getVisitoryRefById(model.visitorId),
      createdAt: model.createdAt,
      qrCodeToken: model.qrCodeToken,
      fromDate: model.fromDate,
      toDate: model.toDate,
      maxEntries: model.maxEntries,
      logs: await _accessLogRepository.getAccessLogsByInvitationId(model.id),
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
