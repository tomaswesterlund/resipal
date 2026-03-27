import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart'; // Required for WidgetsBindingObserver
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:rxdart/rxdart.dart';

class SessionService with WidgetsBindingObserver {
  final LoggerService _logger = GetIt.I<LoggerService>();

  bool get isDebug => kDebugMode;

  ResipalApplication? _app;
  ResipalApplication get app {
    if (_app == null) {
      final error = StateError('_app is null');
      _logger.error(featureArea: 'SessionService.app', exception: error);
      throw error;
    }
    return _app!;
  }

  String? _communityId;
  String get communityId {
    if (_communityId == null) {
      final error = StateError('_communityId is null');
      _logger.error(featureArea: 'SessionService.communityId', exception: error);
      throw error;
    }
    return _communityId!;
  }

  String? _userId;
  String get userId {
    if (_userId == null) {
      final error = StateError('_userId is null');
      _logger.error(featureArea: 'SessionService.userId', exception: error);
      throw error;
    }
    return _userId!;
  }

  // --- Initialization ---

  SessionService() {
    WidgetsBinding.instance.addObserver(this);
  }

  void setUserId(String userId) => _userId = userId;

  // --- Lifecycle Handling ---

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When returning to the app on iOS, the Realtime connection might be dead.
    // We trigger a re-sync to ensure the cache is fresh.
    if (state == AppLifecycleState.resumed && _communityId != null) {
      _logger.info(
        featureArea: 'SessionService',
        message: 'App Resumed: Refreshing community session for $_communityId',
      );
      _refreshCurrentSession();
    }
  }

  // --- Streaming Logic ---

  final CompositeSubscription _subscriptions = CompositeSubscription();

  Future<void> startCommunityWatchers({
    required ResipalApplication app,
    required String communityId,
    required String userId,
  }) async {
    await stopWatchers();

    _app = app;
    _communityId = communityId;
    _userId = userId;

    try {
      await _refreshCurrentSession();
      _logger.info(featureArea: 'SessionService', message: 'Watchers started successfully for community: $communityId');
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'SessionService.startWatchers',
        stackTrace: s,
        metadata: {'communityId': communityId, 'userId': userId},
      );
      rethrow;
    }
  }

  Future<void> _refreshCurrentSession() async {
    final cid = _communityId;
    final uid = _userId;
    if (cid == null || uid == null) return;

    _subscriptions.clear();

    try {
      await Future.wait([
        _setupSubscription(GetIt.I<CommunityDataSource>().watchById(cid)),
        _setupSubscription(GetIt.I<UserDataSource>().watchById(uid)),
        _setupSubscription(GetIt.I<ApplicationDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<ContractDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<EmailInvitationDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<InvitationDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<MaintenanceFeeDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<MembershipDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<NotificationDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<PaymentDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<PropertyDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<VisitorDataSource>().watchByCommunityId(cid)),
        _setupSubscription(GetIt.I<AccessLogDataSource>().watchByCommunityId(cid)),
      ]);
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'SessionService._refreshCurrentSession', stackTrace: s);
    }
  }

  Future<void> stopWatchers() async {
    try {
      _subscriptions.clear();
      _communityId = null;
      _userId = null;
      _app = null;

      _logger.info(featureArea: 'SessionService', message: 'SessionService: All watchers stopped and session cleared.');
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'SessionService.stopWatchers', stackTrace: s);
    }
  }

  Future<void> _setupSubscription<T>(Stream<T> stream) async {
    try {
      // Ensure first emission (REST/Cache) is handled before proceeding
      await stream.first.timeout(const Duration(seconds: 10));

      final sub = stream.listen((data) {
        /* Internal repository update handled by DataSource */
      }, onError: (e, s) => _logger.error(exception: e, featureArea: 'SessionService.Stream', stackTrace: s));

      _subscriptions.add(sub);
    } catch (e, s) {
      _logger.error(exception: e, featureArea: 'SessionService._setupSubscription', stackTrace: s);
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopWatchers();
    _subscriptions.dispose();
  }
}
