import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:resipal_core/data/sources/error_log_data_source.dart';

class LoggerService {
  // final AuthService _authService = GetIt.I<AuthService>();
  final ErrorLogDataSource _errorDataSource = GetIt.I<ErrorLogDataSource>();

  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true),
    filter: DevelopmentFilter(),
  );

  Future logException({
    required String featureArea,
    required dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) async {
    _logger.e('Exception in $featureArea', error: exception, stackTrace: stackTrace);

    try {
      final info = await PackageInfo.fromPlatform();

      await _errorDataSource.logError(
        errorMessage: exception.toString(),
        stackTrace: stackTrace?.toString(),
        platform: kIsWeb ? 'web' : Platform.operatingSystem,
        appVersion: '${info.version}+${info.buildNumber}',
        featureArea: featureArea,
        metadata: metadata,
      );
    } catch (e) {
      // Fallback if the DataSource or Network fails
      _logger.w('Failed to upload log to Supabase: $e');
    }
  }

  void info(String message) => _logger.i(message);
  void debug(String message) => _logger.d(message);
}
