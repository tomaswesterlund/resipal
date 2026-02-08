// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:resipal/domain/repositories/ledger_repository.dart';
import 'package:rxdart/streams.dart';

import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/user_model.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/refs/user_ref.dart';
import 'package:resipal/domain/repositories/property_repository.dart';

class UserRepository {
  final LoggerService _logger;
  final UserDataSource _userDataSource;
  final LedgerRepository _ledgerRepository;
  final PropertyRepository _propertyRepository;

  final Map<String, UserEntity> _cache = {};

  UserRepository(this._logger, this._userDataSource, this._ledgerRepository, this._propertyRepository);

  Future initialize() async {
    final firstData = await _userDataSource.watchUsers().first;
    _processAndCache(firstData);
    _logger.info('✅ UserRepository initialized');
  }

  UserEntity getUserById(String id) => _cache.values.firstWhere((u) => u.id == id);

  /// Fetched the user from the data source which is sometimes needed if a user is created but the stream has not yet emitted the new user. After fetching, the user will be in the cache and can be accessed with [getUserById].
  Future fetchUser(String id) async {
    final model = await _userDataSource.getUserById(id);
    final entity = await _toEntity(model);
    _cache[id] = entity;
  }

  UserRef getUserRefById(String id) {
    final user = getUserById(id);
    return UserRef(id: user.id, name: user.name);
  }

  bool userExists(String id) => _cache.containsKey(id);

  Future createUser({
    required String id,
    required String name,
    required String phoneNumber,
    required String emergencyPhoneNumber,
    required String email,
  }) async => _userDataSource.createUser(
    id: id,
    name: name,
    phoneNumber: phoneNumber,
    emergencyPhoneNumber: emergencyPhoneNumber,
    email: email,
  );

  Future<UserEntity> _toEntity(UserModel model) async {
    final ledger = _ledgerRepository.getLedgerByUserId(model.id);
    final properties = _propertyRepository.getPropertiesByOwnerId(model.id);

    return UserEntity(
      id: model.id,
      createdAt: model.createdAt,
      name: model.name,
      phoneNumber: model.phoneNumber,
      emergencyPhoneNumber: model.emergencyPhoneNumber,
      email: model.email,
      invitations: [],
      ledger: ledger,
      payments: [],
      properties: properties
    );
  }

  Future<List<UserEntity>> _processAndCache(List<UserModel> models) async {
    final futures = models.map((model) async {
      if (_cache.containsKey(model.id)) {
        return _cache[model.id]!;
      }

      final entity = await _toEntity(model);
      _cache[model.id] = entity;
      return entity;
    }).toList();

    final list = Future.wait(futures);
    return list;
  }
}
