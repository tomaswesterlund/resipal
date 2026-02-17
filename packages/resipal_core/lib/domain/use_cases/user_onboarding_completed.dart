import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/domain/use_cases/user_has_joined_any_community.dart';

class UserOnboardingCompleted {
  final UserDataSource _source = GetIt.I<UserDataSource>();
  Future<bool> call(String userId) async {
    final user = _source.getById(userId);
    if (user == null) return false;

    // TODO Make sure all User Data are filled out (create a new Use Cases)

    final userHasJoinedAnyCommunity = UserHasJoinedAnyCommunity().call(userId);
    if (userHasJoinedAnyCommunity == false) return false;

    return true;
  }
}
