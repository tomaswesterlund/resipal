import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchMemberByCommunityAndUserId {
  final CommunityDataSource _communityDataSource = GetIt.I<CommunityDataSource>();
  final MaintenanceFeeDataSource _maintenanceFeeDataSource = GetIt.I<MaintenanceFeeDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();
  final GetMemberByUserAndCommunityId _getMemberByUserAndCommunityId = GetMemberByUserAndCommunityId();

  Stream<MemberEntity> call({required String communityId, required String userId}) {
    return CombineLatestStream.combine5(
      _communityDataSource.watchById(communityId),
      _maintenanceFeeDataSource.watchByCommunityId(communityId),
      _paymentDataSource.watchByUserId(userId),
      _propertyDataSource.watchByResidentId(userId),
      _userDataSource.watchById(userId),
      (community, fees, payments, properties, user) {
        final member = _getMemberByUserAndCommunityId.call(communityId: communityId, userId: userId);
        return member;
      },
    ).distinct();
  }
}
