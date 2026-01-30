import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/models/user_model.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/domain/refs/user_ref.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:rxdart/streams.dart';

class UserRepository {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();

  final Map<String, UserEntity> _cache = {};
  late Stream<List<UserEntity>> _stream;

  UserRepository() {
    _stream = _userDataSource
        .watchUsers()
        .map((models) => _processAndCache(models))
        .shareValue();
  }

  Future initialize() async  {
    final firstData = await _userDataSource.watchUsers().first;
    _processAndCache(firstData);
    _stream.listen((_) {}, onError: (e) => print('User Stream Error: $e'));
    _logger.info('✅ UserRepository initialized');
  }

  UserEntity getUserById(String id) =>
      _cache.values.firstWhere((u) => u.id == id);

  UserRef getUserRefById(String id) {
    final user = getUserById(id);
    return UserRef(id: user.id, name: user.name);
  }

  UserEntity _toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      createdAt: model.createdAt,
      name: model.name,
      phoneNumber: model.phoneNumber,
      emergencyPhoneNumber: model.emergencyPhoneNumber,
      email: model.email,
      invitations: [],
      movements: [],
      payments: [],
      // properties: properties
    );
  }

  List<UserEntity> _processAndCache(List<UserModel> models) {
    return models.map((model) {
      if (_cache.containsKey(model.id)) {
        return _cache[model.id]!;
      }

      final entity = _toEntity(model);
      _cache[model.id] = entity;
      return entity;
    }).toList();
  }
}
