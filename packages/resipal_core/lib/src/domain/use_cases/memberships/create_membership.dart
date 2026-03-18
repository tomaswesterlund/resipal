import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/models/membership/upsert_membership_model.dart';

class CreateMembership {
  final MembershipDataSource _source = GetIt.I<MembershipDataSource>();

  Future<MembershipId> call({
    required String communityId,
    required String userId,
    required bool isAdmin,
    required bool isResident,
    required bool isSecurity,
  }) async {
    final model = UpsertMembershipModel(userId: userId, communityId: communityId, isAdmin: isAdmin, isResident: isResident, isSecurity: isSecurity);
    return await _source.upsert(model);
  }
}