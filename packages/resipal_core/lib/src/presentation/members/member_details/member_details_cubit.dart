import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class MemberDetailsCubit extends Cubit<MemberDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  // Assuming a WatchMemberById use case exists, similar to your application one
  final WatchMemberByCommunityAndUserId _watchMember = WatchMemberByCommunityAndUserId();
  StreamSubscription? _streamSubscription;

  MemberDetailsCubit() : super(MemberDetailsInitialState());

  Future initialize(MemberEntity member) async {
    try {
      emit(MemberDetailsLoadedState(member));

      _streamSubscription = _watchMember
          .call(
            communityId: member.community.id,
            userId: member.user.id
            )
          .listen(
            (updatedMember) async {
              emit(MemberDetailsLoadedState(updatedMember));
            },
            onError: (e, s) {
              _logger.error(
                featureArea: 'MemberDetailsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'member': member.toMap()},
              );
              emit(MemberDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'MemberDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'member': member.toMap()},
      );
      emit(MemberDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
