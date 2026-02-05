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

  Future initialize() async {
    final firstData = await _userDataSource.watchUsers().first;
    _processAndCache(firstData);
    _stream.listen((_) {}, onError: (e) => print('User Stream Error: $e'));
    _logger.info('✅ UserRepository initialized');
  }

  UserEntity getUserById(String id) =>
      _cache.values.firstWhere((u) => u.id == id);

  /// Fetched the user from the data source which is sometimes needed if a user is created but the stream has not yet emitted the new user. After fetching, the user will be in the cache and can be accessed with [getUserById].
  Future fetchUser(String id) async {
    final model = await _userDataSource.getUserById(id);
    final entity = _toEntity(model);
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
