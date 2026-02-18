import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/data/sources/community_application_data_source.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:rxdart/rxdart.dart';

class UserSessionService {
  final CompositeSubscription _subscriptions = CompositeSubscription();
  final CompositeSubscription _propertyDependenciesSubscriptions = CompositeSubscription();

  Future<void> initializeUserScope(String userId) async {
    _subscriptions.clear();
    _propertyDependenciesSubscriptions.clear();

    try {
      await Future.wait([
        _setupSubscription(GetIt.I<UserDataSource>().watchById(userId)),
        _setupSubscription(GetIt.I<CommunityDataSource>().watchAll()),
        _setupSubscription(GetIt.I<CommunityApplicationDataSource>().watchByUserId(userId)),
        _setupSubscription(GetIt.I<InvitationDataSource>().watchByUserId(userId)),
        _setupSubscription(GetIt.I<PaymentDataSource>().watchByUserId(userId)),
        _setupSubscription(GetIt.I<VisitorDataSource>().watchByUserId(userId)),
        _setupPropertyAndDependencies(userId),
      ]);
    } catch (e) {}
  }

  Future<void> _setupPropertyAndDependencies(String userId) async {
    final propertyStream = GetIt.I<PropertyDataSource>().watchByResidentId(userId);
    final properties = await propertyStream.first;

    // Keep property list reactive
    _subscriptions.add(propertyStream.listen((_) {}));

    // Start listening to Fees/Contracts for each property
    // We don't await these inside the Future.wait if we want the UI to show
    // as soon as basic property info is ready, OR we can await them if
    // we want a "fully loaded" experience.
    final List<Future> dependencyFutures = [];

    for (var p in properties) {
      if (p.contractId != null) {
        dependencyFutures.add(_setupSubscription(GetIt.I<MaintenanceContractDataSource>().watchById(p.contractId!)));
      }
      dependencyFutures.add(_setupSubscription(GetIt.I<MaintenanceFeeDataSource>().watchByPropertyId(p.id)));
    }

    await Future.wait(dependencyFutures);
  }

  Future<void> _setupSubscription<T>(Stream<T> stream) async {
    await stream.first;
    final sub = stream.listen((_) {});
    _subscriptions.add(sub);
  }

  void dispose() {
    _subscriptions.dispose();
    _propertyDependenciesSubscriptions.dispose();
  }
}
