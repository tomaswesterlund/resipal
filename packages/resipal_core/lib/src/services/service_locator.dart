import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/data/sources/notification_data_source.dart';
import 'package:resipal_core/src/data/sources/whatsapp_data_source.dart';
import 'package:resipal_core/src/data/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceLocator {
  Future<void> initializeContainers() async {
    final sl = GetIt.instance;

    final config = GetIt.I<SupabaseConfig>();
    await Supabase.initialize(url: config.url, anonKey: config.anonKey);

    sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

    // Services
    sl.registerLazySingleton(() => AuthService());
    sl.registerLazySingleton(() => ImageService());
    sl.registerLazySingleton(() => NotificationService());
    sl.registerLazySingleton(() => LoggerService());
    sl.registerLazySingleton(() => PdfService());

    // Data sources
    sl.registerLazySingleton(() => AccessLogDataSource());
    sl.registerLazySingleton(() => ApplicationDataSource());
    sl.registerLazySingleton(() => CommunityDataSource());
    sl.registerLazySingleton(() => ContractDataSource());
    sl.registerLazySingleton(() => EmailInvitationDataSource());
    sl.registerLazySingleton(() => EmailLogDataSource());
    sl.registerLazySingleton(() => InvitationDataSource());
    sl.registerLazySingleton(() => LogDataSource());
    sl.registerLazySingleton(() => NotificationDataSource());
    sl.registerLazySingleton(() => MaintenanceFeeDataSource());
    sl.registerLazySingleton(() => MembershipDataSource());
    sl.registerLazySingleton(() => MovementDataSource());
    sl.registerLazySingleton(() => PaymentDataSource());
    sl.registerLazySingleton(() => PropertyDataSource());
    sl.registerLazySingleton(() => VisitorDataSource());
    sl.registerLazySingleton(() => UserDataSource());
    sl.registerLazySingleton(() => WhatsAppDataSource());
  }
}
