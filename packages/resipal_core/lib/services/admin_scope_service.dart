import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/access_log_data_source.dart';
import 'package:resipal_core/data/sources/error_log_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/data/sources/movement_data_source.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/data/sources/community_application_data_source.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/services/auth_service.dart';
import 'package:resipal_core/services/image_service.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminScopeService {
  final CompositeSubscription _subscriptions = CompositeSubscription();

  Future<void> init() async {
    final sl = GetIt.instance;

    // Supabase
    await Supabase.initialize(url: 'https://xapfoiggbgutbmcqrgma.supabase.co', anonKey: 'sb_publishable_I1FzA8ioJ1zPOhpFjld_vA_p2Pip5pw');
    sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

    // Services
    sl.registerLazySingleton(() => LoggerService());
    sl.registerLazySingleton(() => ImageService());
    sl.registerLazySingleton(() => AuthService());

    // Data sources
    sl.registerLazySingleton(() => AccessLogDataSource());
    sl.registerLazySingleton(() => CommunityApplicationDataSource());
    sl.registerLazySingleton(() => CommunityDataSource());
    sl.registerLazySingleton(() => ErrorLogDataSource());
    sl.registerLazySingleton(() => InvitationDataSource());
    sl.registerLazySingleton(() => MaintenanceContractDataSource());
    sl.registerLazySingleton(() => MaintenanceFeeDataSource());
    sl.registerLazySingleton(() => MovementDataSource());
    sl.registerLazySingleton(() => PaymentDataSource());
    sl.registerLazySingleton(() => PropertyDataSource());
    sl.registerLazySingleton(() => VisitorDataSource());
    sl.registerLazySingleton(() => UserDataSource());
  }

  Future<void> initializeUserScope(String userId) async {
    _subscriptions.clear();

    try {
      await Future.wait([_setupSubscription(GetIt.I<UserDataSource>().watchById(userId))]);
    } catch (e) {}
  }

  Future<void> initializeCommununityScope(String communityId) async {
    _subscriptions.clear();

    try {
      await Future.wait([
        //_setupSubscription(GetIt.I<UserDataSource>().watchById(userId)),
        _setupSubscription(GetIt.I<CommunityDataSource>().watchById(communityId)),
        _setupSubscription(GetIt.I<CommunityApplicationDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<InvitationDataSource>().watchByCommunityId(communityId)),
        _setupSubscription(GetIt.I<MaintenanceContractDataSource>().watchByCommunityId(communityId)),
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
