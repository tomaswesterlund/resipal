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
import 'package:resipal/domain/repositories/access_log_repository.dart';
import 'package:resipal/domain/repositories/community_repository.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/domain/repositories/ledger_repository.dart';
import 'package:resipal/domain/repositories/maintenance_repository.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import all your services, data sources, and repositories here...

final sl = GetIt.instance; // Short alias for Service Locator

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

    // 2. Data Sources
    _initDataSources();

    // 3. Repositories
    await _initRepositories();
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

  static Future<void> _initRepositories() async {
    final communityRepository = CommunityRepository(sl<LoggerService>(), sl<CommunityDataSource>());
    await communityRepository.initialize();

    final paymentRepository = PaymentRepository();
    await paymentRepository.initialize();

    final maintenanceRepository = MaintenanceRepository(
      sl<MaintenanceContractDataSource>(),
      sl<MaintenanceFeeDataSource>(),
    );

    final propertyRepository = PropertyRepository(sl<LoggerService>(), sl<PropertyDataSource>(), maintenanceRepository);
    await propertyRepository.initialize();

    final userRepository = UserRepository(sl<LoggerService>(), sl<UserDataSource>(), propertyRepository);
    await userRepository.initialize();

    final ledgerRepository = LedgerRepository(
      sl<LoggerService>(),
      sl<MovementDataSource>(),
      maintenanceRepository,
      paymentRepository,
    );
    await ledgerRepository.initialize();

    final visitorRepository = VisitorRepository();
    final accessLogRepository = AccessLogRepository();

    final invitationRepository = InvitationRepository(
      sl<LoggerService>(),
      sl<InvitationDataSource>(),
      accessLogRepository,
      propertyRepository,
      userRepository,
      visitorRepository,
    );

    // 3. Registering the fully initialized instances
    sl.registerSingleton<AccessLogRepository>(accessLogRepository);
    sl.registerSingleton<CommunityRepository>(communityRepository);
    sl.registerSingleton<InvitationRepository>(invitationRepository);
    sl.registerSingleton<MaintenanceRepository>(maintenanceRepository);
    sl.registerSingleton<LedgerRepository>(ledgerRepository);
    sl.registerSingleton<PaymentRepository>(paymentRepository);
    sl.registerSingleton<PropertyRepository>(propertyRepository);
    sl.registerSingleton<VisitorRepository>(visitorRepository);
    sl.registerSingleton<UserRepository>(userRepository);
  }
}
