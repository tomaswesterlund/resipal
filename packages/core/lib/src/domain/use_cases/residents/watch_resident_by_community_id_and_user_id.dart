import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchResidentByCommunityIdAndUserId {
  final AccessLogDataSource _accessLogDataSource = GetIt.I<AccessLogDataSource>();
  final CommunityDataSource _communityDataSource = GetIt.I<CommunityDataSource>();
  final InvitationDataSource _invitationDataSource = GetIt.I<InvitationDataSource>();
  final MaintenanceFeeDataSource _maintenanceFeeDataSource = GetIt.I<MaintenanceFeeDataSource>();
  final NotificationDataSource _notificationDataSource = GetIt.I<NotificationDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();
  final VisitorDataSource _visitorDataSource = GetIt.I<VisitorDataSource>();
  final UserDataSource _userDataSource = GetIt.I<UserDataSource>();
  final GetResidentByCommunityIdAndUserId _getResidentByCommunityIdAndUserId = GetResidentByCommunityIdAndUserId();

  Stream<ResidentMemberEntity> call({required String communityId, required String userId}) {
    return CombineLatestStream.combine9(
      _accessLogDataSource.watchByCommunityId(communityId),
      _communityDataSource.watchById(communityId),
      _invitationDataSource.watchByCommunityId(communityId),
      _maintenanceFeeDataSource.watchByCommunityId(communityId),
      _notificationDataSource.watchByCommunityId(communityId),
      _paymentDataSource.watchByUserId(userId),
      _propertyDataSource.watchByResidentId(userId),
      _visitorDataSource.watchByUserId(userId),
      _userDataSource.watchById(userId),
      (accessLogs, community, invitations, fees, notiifcations, payments, properties, visitors, user) {
        final member = _getResidentByCommunityIdAndUserId.call(communityId: communityId, userId: userId);
        return member;
      },
    ).distinct();
  }
}
