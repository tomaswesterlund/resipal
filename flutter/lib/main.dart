import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/data/sources/movement_data_source.dart';
import 'package:resipal/data/sources/payment_data_source.dart';
import 'package:resipal/data/sources/property_data_source.dart';
import 'package:resipal/data/sources/user_data_source.dart';
import 'package:resipal/data/sources/visitor_data_source.dart';
import 'package:resipal/domain/repositories/invitation_repository.dart';
import 'package:resipal/domain/repositories/movement_repository.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/domain/repositories/visitor_repository.dart';
import 'package:resipal/presentation/signin/signin_page.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'http://127.0.0.1:54321    ',
    anonKey: 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH',
  );

  GetIt.I.registerSingleton(Supabase.instance.client);

  GetIt.I.registerSingleton(InvitationDataSource());
  GetIt.I.registerSingleton(MovementDataSource());
  GetIt.I.registerSingleton(PaymentDataSource());
  GetIt.I.registerSingleton(PropertyDataSource());
  GetIt.I.registerSingleton(VisitorDataSource());
  GetIt.I.registerSingleton(UserDataSource());

  GetIt.I.registerSingleton(InvitationRepository());
  GetIt.I.registerSingleton(MovementRepository());
  GetIt.I.registerSingleton(PaymentRepository());
  GetIt.I.registerSingleton(PropertyRepository());
  GetIt.I.registerSingleton(VisitorRepository());
  GetIt.I.registerSingleton(UserRepository());

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Go.navigatorKey,
      home: Scaffold(backgroundColor: Color(0xFF1E1E1E), body: SigninPage()),
    );
  }
}
