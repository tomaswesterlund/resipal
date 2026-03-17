import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resipal_admin/app_colors.dart';
import 'package:resipal_admin/presentation/auth/auth_gate.dart';
import 'package:resipal_core/lib.dart';
import 'package:short_navigation/short_navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Setup Supabase
  final supabaseConfig = SupabaseConfig(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  GetIt.instance.registerSingleton<SupabaseConfig>(supabaseConfig);

  // Setup Auth Config
  final authConfig = AuthServiceConfig(
    iosClientId: dotenv.get('GOOGLE_OAUTH_IOS_CLIENT_ID'),
    serverClientId: dotenv.get('GOOGLE_OAUTH_SERVER_CLIENT_ID'),
  );
  GetIt.instance.registerSingleton<AuthServiceConfig>(authConfig);

  await ServiceLocator().initializeContainers();
  GetIt.instance.registerSingleton<SessionService>(SessionService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Go.navigatorKey,
      title: 'Resipal - Administrator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          // --- Brand ---
          primary: AppColors.primary700,
          onPrimary: Colors.white,
          primaryContainer: AppColors.primary100,
          onPrimaryContainer: AppColors.primary900,

          // --- Secondary (Terracotta) ---
          secondary: AppColors.secondary500,
          onSecondary: Colors.white,
          secondaryContainer: AppColors.secondary100,
          onSecondaryContainer: AppColors.secondary900,

          // --- Surfaces ---
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          background: AppColors.background,
          onBackground: AppColors.textPrimary,

          // --- Feedback ---
          error: AppColors.danger500,
          onError: Colors.white,

          // --- Neutral / Outline ---
          outline: AppColors.grey500,
          outlineVariant: AppColors.grey200,

          // --- Additional mapping ---
          tertiary: AppColors.success700,
          onTertiary: Colors.white,
          tertiaryContainer: AppColors.success100,
          onTertiaryContainer: AppColors.success900,
        ),
        appBarTheme: AppBarTheme(backgroundColor: AppColors.background),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: TextTheme(
          // HEADINGS (TÍTULOS)
          displayLarge: GoogleFonts.raleway(
            fontSize: 48,
            height: 54 / 48,
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: GoogleFonts.raleway(
            fontSize: 32,
            height: 40 / 32,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.raleway(
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.bold
          ),
          headlineSmall: GoogleFonts.raleway(
            fontSize: 20,
            height: 28 / 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.raleway(
            fontSize: 18,
            height: 24 / 18,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.raleway(
            fontSize: 16,
            height: 20 / 16,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: GoogleFonts.raleway(
            fontSize: 14,
            height: 16 / 14,
            fontWeight: FontWeight.bold,
          ),

          bodyLarge: GoogleFonts.raleway(
            fontSize: 18,
            height: 28 / 18,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: GoogleFonts.raleway(
            fontSize: 16,
            height: 24 / 16,
            fontWeight: FontWeight.normal,
          ),
          bodySmall: GoogleFonts.raleway(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.normal,
          ),
          labelSmall: GoogleFonts.poppins(
            // Caption / Tiny
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
