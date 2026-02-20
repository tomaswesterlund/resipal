import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/resipal_subabase.dart';
import 'package:resipal_core/data/sources/access_log_data_source.dart';
import 'package:resipal_core/data/sources/membership_data_source.dart';
import 'package:resipal_core/data/sources/error_log_data_source.dart';
import 'package:resipal_core/data/sources/contract_data_source.dart';
import 'package:resipal_core/data/sources/maintenance_fee_data_source.dart';
import 'package:resipal_core/data/sources/movement_data_source.dart';
import 'package:resipal_core/data/sources/user_data_source.dart';
import 'package:resipal_core/data/sources/application_data_source.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/data/sources/property_data_source.dart';
import 'package:resipal_core/data/sources/visitor_data_source.dart';
import 'package:resipal_core/services/auth_service.dart';
import 'package:resipal_core/services/image_service.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceLocator {
  Future<void> initializeContainers() async {
    final sl = GetIt.instance;

    final supabase = ResipalSupabase();
    await supabase.init();
    sl.registerSingleton<ResipalSupabase>(supabase);
    sl.registerSingleton<SupabaseClient>(supabase.client);

    // Services
    sl.registerLazySingleton(() => LoggerService());
    sl.registerLazySingleton(() => ImageService());
    sl.registerLazySingleton(() => AuthService());

    // Data sources
    sl.registerLazySingleton(() => AccessLogDataSource());
    sl.registerLazySingleton(() => ApplicationDataSource());
    sl.registerLazySingleton(() => MembershipDataSource());
    sl.registerLazySingleton(() => CommunityDataSource());
    sl.registerLazySingleton(() => ErrorLogDataSource());
    sl.registerLazySingleton(() => InvitationDataSource());
    sl.registerLazySingleton(() => ContractDataSource());
    sl.registerLazySingleton(() => MaintenanceFeeDataSource());
    sl.registerLazySingleton(() => MovementDataSource());
    sl.registerLazySingleton(() => PaymentDataSource());
    sl.registerLazySingleton(() => PropertyDataSource());
    sl.registerLazySingleton(() => VisitorDataSource());
    sl.registerLazySingleton(() => UserDataSource());
  }
}
