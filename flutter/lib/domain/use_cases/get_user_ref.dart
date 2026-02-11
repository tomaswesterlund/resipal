import 'package:get_it/get_it.dart';
import 'package:resipal/data/models/user_model.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/domain/refs/user_ref.dart';

class GetUserRef {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  UserRef fromId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Community $id not found in cache. Ensure the stream is active.');
    }

    return fromModel(model);
  }

  UserRef fromModel(UserModel model) => UserRef(id: model.id, name: model.name);
}
