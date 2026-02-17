import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/presentation/shared/colors/app_colors.dart';
import 'package:resipal_core/services/user_scope_service.dart';
import 'package:resipal_user/presentation/auth/auth_page.dart';
import 'package:short_navigation/short_navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userScopeService = UserScopeService();
  await userScopeService.init();
  GetIt.instance.registerSingleton<UserScopeService>(userScopeService);

  runApp(const MyApp());
}

// Initialize app
// Signin
// Load data / watchers
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Go.navigatorKey,
      title: 'Resipal',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(backgroundColor: AppColors.background, body: AuthPage()),
    );
  }
}
