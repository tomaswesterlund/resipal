import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/core/services/image_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/data/sources/access_log_data_source.dart';
import 'package:resipal/data/sources/community_data_source.dart';
import 'package:resipal/data/sources/error_log_data_source.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/data/sources/maintenance_contract_data_source.dart';
import 'package:resipal/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal/data/sources/movement_data_source.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
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

    _initDataSources();
    // _initMappers();

    // await _initRepositories();
  }

  static void _initDataSources() {
    sl.registerLazySingleton(() => AccessLogDataSource());
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

  // static void _initMappers() {
  //   sl.registerLazySingleton(() => CommunityMapper());
  //   sl.registerLazySingleton(() => MaintenanceContractMapper());
  //   sl.registerLazySingleton(() => MaintenanceFeeMapper());
  //   sl.registerLazySingleton(() => PropertyMapper());
  // }

  // static Future<void> _initRepositories() async {
  //   sl.registerLazySingleton(() => AccessLogRepository());
  //   sl.registerLazySingleton(() => CommunityRepository());
  //   sl.registerLazySingleton(() => MaintenanceContractRepository());
  //   sl.registerLazySingleton(() => MaintenanceFeeRepository());
  //   sl.registerLazySingleton(() => PaymentRepository());
  //   // sl.registerLazySingleton(() => PropertyRepository());
  //   sl.registerLazySingleton(() => VisitorRepository());
  //   sl.registerLazySingleton(() => UserRepository());
  // }

  static Future<void> initializeUserScope(String userId) async {
    // TODO: Remove hard-coded community id
    final communityId = '401989eb-2fe6-4c2f-b2e9-82f91e2e916d';

    await GetIt.I<UserDataSource>().watchById(userId).first;
    await GetIt.I<InvitationDataSource>().watchByUserId(userId).first;
    await GetIt.I<MaintenanceContractDataSource>().watchByCommunityId(communityId).first;
    await GetIt.I<MaintenanceFeeDataSource>().watchByCommunityId(communityId).first;
    await GetIt.I<PropertyDataSource>().watchByOwnerId(userId).first;
    await GetIt.I<PaymentDataSource>().watchByUserId(userId).first;
    await GetIt.I<VisitorDataSource>().watchByUserId(userId).first;
  }
}
