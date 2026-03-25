import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:rxdart/streams.dart';

class AdminHomeCubit extends Cubit<AdminHomeState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final NotificationService _notificationService = GetIt.I<NotificationService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  StreamSubscription? _streamSubscription;

  AdminHomeCubit() : super(AdminInitialState());

  Future<void> initialize(AdminMemberEntity admin, CommunityEntity community) async {
    try {
      emit(AdminLoadedState(admin, community));
      await _notificationService.initialize(userId: admin.user.id);

      _streamSubscription =
          CombineLatestStream.combine2(
                WatchAdminMemberByCommunityAndUserId().call(communityId: community.id, userId: admin.user.id),
                WatchCommunityById().call(communityId: community.id),
                (adminMember, communityData) {
                  return (adminMember, communityData);
                },
              )
              .distinct()
              .handleError((e, s) {
                _logger.error(exception: e, stackTrace: s, featureArea: 'AdminHomeCubit.initialize / listener');
                emit(AdminErrorState());
              })
              .listen((data) {
                // 2. EMIT happens here in the listener
                final adminMember = data.$1;
                final communityData = data.$2;
                emit(AdminLoadedState(adminMember, communityData));
              });
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'AdminHomeCubit.initialize');
      emit(AdminErrorState());
    }
  }

  Future signout() async {
    await _authService.signout();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
