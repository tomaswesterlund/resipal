import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/data/sources/error_log_data_source.dart';
import 'package:resipal/data/models/error_log_model.dart';
import 'package:resipal/domain/use_cases/get_user.dart';
import 'package:uuid/uuid.dart';

class LoggerService {
  // final AuthService _authService = GetIt.I<AuthService>();
  final ErrorLogDataSource _errorDataSource = GetIt.I<ErrorLogDataSource>();

  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 2, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true),
    filter: DevelopmentFilter(),
  );

  Future logException({
    required dynamic exception,
    required String featureArea,
    required StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) async {
    _logger.e('Exception in $featureArea', error: exception, stackTrace: stackTrace);

    try {
      final info = await PackageInfo.fromPlatform();

      // TODO How to get the User and Community ID into the table?
      // String? userId;
      // String? communityId;

      // if (_authService.userIsSignedIn) {
      //   final user = GetUser().call(_authService.getSignedInUserId());

      //   userId = user.id;
      //   communityId = user.community.id;
      // }

      final errorLog = ErrorLogModel(
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        communityId: null,
        userId: null,
        errorMessage: exception.toString(),
        stackTrace: stackTrace?.toString(),
        platform: kIsWeb ? 'web' : Platform.operatingSystem,
        appVersion: '${info.version}+${info.buildNumber}',
        featureArea: featureArea,
        metadata: metadata,
      );

      await _errorDataSource.insert(errorLog);
    } catch (e) {
      // Fallback if the DataSource or Network fails
      _logger.w('Failed to upload log to Supabase: $e');
    }
  }

  void info(String message) => _logger.i(message);
  void debug(String message) => _logger.d(message);
}
