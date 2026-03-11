import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetUsersByCommunity {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetUserById _getUser = GetUserById();

  List<UserEntity> call(String communityId) {
    final models = _source.getByCommunityId(communityId);
    final entities = models.map((x) => _getUser.call(x.id)).toList();
    return entities;
  }
}