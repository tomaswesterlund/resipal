import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetMembershipsByUserId {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();
  final GetMembershipById _getMembershipById = GetMembershipById();

  List<MembershipEntity> call({required String userId}) {
    final memberships = _source.getByUserId(userId);
    return memberships.map((x) => _getMembershipById.call(x.id)).toList();

  }
}
