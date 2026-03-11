import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateMembership {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  Future<MembershipId> call({
    required String communityId,
    required String userId,
    required bool isAdmin,
    required bool isResident,
    required bool isSecurity,
  }) async => _source.createMembership(
    communityId: communityId,
    userId: userId,
    isAdmin: isAdmin,
    isResident: isResident,
    isSecurity: isSecurity,
  );
}