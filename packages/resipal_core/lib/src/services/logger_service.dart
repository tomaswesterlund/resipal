import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:resipal_core/src/data/sources/log_data_source.dart';

class LoggerService {
  final LogDataSource _errorDataSource = GetIt.I<LogDataSource>();

  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true),
    filter: DevelopmentFilter(),
  );

  /// Logs an exception to the console and persists it to the database as an ERROR
  Future<void> error({
    required String featureArea,
    required dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) async {
    _logger.e('Exception in $featureArea', error: exception, stackTrace: stackTrace);
    await _persistToDatabase(
      featureArea: featureArea,
      message: exception.toString(),
      stackTrace: stackTrace,
      metadata: metadata,
      isError: true,
    );
  }

  /// Logs information to the console and persists it to the database as an INFO entry
  Future<void> info({
    required String featureArea,
    required String message,
    Map<String, dynamic>? metadata,
  }) async {
    _logger.i('[$featureArea] $message');
    await _persistToDatabase(
      featureArea: featureArea,
      message: message,
      metadata: metadata,
      isError: false,
    );
  }

  /// Internal helper to handle the common logic of fetching platform info and saving to DB
  Future<void> _persistToDatabase({
    required String featureArea,
    required String message,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
    required bool isError,
  }) async {
    try {
      final info = await PackageInfo.fromPlatform();

      await _errorDataSource.logError(
        errorMessage: message,
        stackTrace: stackTrace?.toString(),
        platform: kIsWeb ? 'web' : Platform.operatingSystem,
        appVersion: '${info.version}+${info.buildNumber}',
        featureArea: featureArea,
        metadata: {
          ...?metadata,
          'log_level': isError ? 'ERROR' : 'INFO',
        },
      );
    } catch (e) {
      _logger.w('Failed to upload log to database: $e');
    }
  }

  void debug(String message) => _logger.d(message);
}