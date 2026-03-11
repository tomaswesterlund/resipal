import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class UpdateUserCommunity {
  final UserDataSource _source = GetIt.I<UserDataSource>();

  Future call({required String userId, required String communityId}) async {
    final user = _source.getById(userId);
    if (user == null) throw Exception('User not found.');

    final updated = user.copyWith(communityId: communityId);
    await _source.upsert(updated.toMap());
  }
}
