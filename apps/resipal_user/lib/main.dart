import 'package:flutter/material.dart';
import 'package:resipal_user/presentation/auth/auth_page.dart';

import 'package:short_navigation/short_navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().initializeContainers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Go.navigatorKey,
      title: 'Resipal',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(backgroundColor: BaseAppColors.background, body: AuthPage()),
    );
  }
}
