import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resipal/core/service_locator.dart';
import 'package:resipal/core/ui/app_colors.dart';
import 'package:resipal/presentation/signin/signin_page.dart';
import 'package:short_navigation/short_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await ServiceLocator.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resipal',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
          surface: AppColors.surface,
        ),
      ),
      navigatorKey: Go.navigatorKey,
      home: Scaffold(backgroundColor: AppColors.background, body: SigninPage()),
    );
  }
}
