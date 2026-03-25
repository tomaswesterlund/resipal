import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class FetchMembershipsByUserId {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  Future call({required String userId}) async {
    await _source.fetchAndCacheByUserId(userId);
  }
}
