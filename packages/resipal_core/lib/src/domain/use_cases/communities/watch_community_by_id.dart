import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:rxdart/streams.dart';

class WatchCommunityById {
  final ApplicationDataSource _applicationDataSource = GetIt.I<ApplicationDataSource>();
  final CommunityDataSource _communitySource = GetIt.I<CommunityDataSource>();
  final ContractDataSource _contractDataSource = GetIt.I<ContractDataSource>();
  final PaymentDataSource _paymentDataSource = GetIt.I<PaymentDataSource>();
  final PropertyDataSource _propertyDataSource = GetIt.I<PropertyDataSource>();

  final GetCommunityById _getCommunityById = GetCommunityById();

  Stream<CommunityEntity> call({required String communityId}) {
    return CombineLatestStream.combine5(
      _applicationDataSource.watchByCommunityId(communityId),
      _communitySource.watchById(communityId),
      _contractDataSource.watchByCommunityId(communityId),
      _paymentDataSource.watchByCommunityId(communityId),
      _propertyDataSource.watchByCommunityId(communityId),

      (applications, community, contracts, payments, properties) {
        final community = _getCommunityById.call(communityId);
        return community;
      },
    ).distinct();
  }
}
