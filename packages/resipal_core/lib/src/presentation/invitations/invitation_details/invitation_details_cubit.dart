import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/invitations/watch_invitation_by_id.dart';
import 'package:resipal_core/src/presentation/invitations/invitation_details/invitation_details_state.dart';

class InvitationDetailsCubit extends Cubit<InvitationDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  StreamSubscription? _streamSubscription;

  InvitationDetailsCubit() : super(InvitationDetailsInitialState());

  Future initialize(InvitationEntity invitation) async {
    try {
      emit(InvitationDetailsLoadedState(invitation));

      _streamSubscription = WatchInvitationById()
          .call(invitation.id)
          .listen(
            (invitation) async {
              emit(InvitationDetailsLoadedState(invitation));
            },
            onError: (e, s) {
              _logger.error(
                featureArea: 'InvitationDetailsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'Invitation': invitation.toMap()},
              );

              emit(InvitationDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'InvitationDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'Invitation': invitation.toMap()},
      );

      emit(InvitationDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
