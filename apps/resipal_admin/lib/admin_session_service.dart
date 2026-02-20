import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';
import 'package:resipal_core/data/sources/contract_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/services/session_service.dart';
import 'package:rxdart/rxdart.dart';

class AdminSessionService extends SessionService {
  final CompositeSubscription _subscriptions = CompositeSubscription();

  Future<void> startWatchers({required String userId, required String communityId}) async {
    _subscriptions.clear();

    try {
      await Future.wait([
        _setupSubscription(GetIt.I<CommunityDataSource>().watchAll()),
        _setupSubscription(GetIt.I<UserDataSource>().watchById(userId)),
        //_setupSubscription(GetIt.I<ApplicationDataSource>().watchByUserId(userId)),
        _setupSubscription(GetIt.I<ApplicationDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<InvitationDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<ContractDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<MaintenanceFeeDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<PaymentDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<PropertyDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<VisitorDataSource>().watchByCommunityId(communityId)),
      ]);
    } catch (e) {}
  }

  Future<void> _setupSubscription<T>(Stream<T> stream) async {
    await stream.first;
    final sub = stream.listen((_) {});
    _subscriptions.add(sub);
  }

  void dispose() {
    _subscriptions.dispose();
  }
}
