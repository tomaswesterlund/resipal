import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/access_log_data_source.dart';
import 'package:resipal_core/data/sources/community_application_data_source.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/data/sources/error_log_data_source.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/data/sources/movement_data_source.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/services/auth_service.dart';
import 'package:resipal_core/services/image_service.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

class SessionService {
  Future<void> init() async {
    // Supabase
    await Supabase.initialize(
      url: 'https://xapfoiggbgutbmcqrgma.supabase.co',
      anonKey: 'sb_publishable_I1FzA8ioJ1zPOhpFjld_vA_p2Pip5pw',
    );
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

  //  Future<void> initializeUserScope(String userId) async {
  //   // TODO: CANCEL PREVIOUS STREAMS!
  //   await GetIt.I<UserDataSource>().watchById(userId).first;
  //   await GetIt.I<CommunityDataSource>().watchAll().first;
  //   await GetIt.I<CommunityApplicationDataSource>().watchByUserId(userId).first;
  //   await GetIt.I<InvitationDataSource>().watchByUserId(userId).first;
  //   await GetIt.I<PropertyDataSource>().watchByOwnerId(userId).first;
  //   await GetIt.I<PaymentDataSource>().watchByUserId(userId).first;
  //   await GetIt.I<VisitorDataSource>().watchByUserId(userId).first;
  // }

  Future<void> initializeAdminScope(String userId) async {
    // TODO: CANCEL PREVIOUS STREAMS!
  }

  static Future<void> initializeCommunityScope(String communityId) async {
    // TODO: CANCEL PREVIOUS STREAMS!
    await GetIt.I<MaintenanceContractDataSource>()
        .watchByCommunityId(communityId)
        .first;
    await GetIt.I<MaintenanceFeeDataSource>()
        .watchByCommunityId(communityId)
        .first;
  }
}
