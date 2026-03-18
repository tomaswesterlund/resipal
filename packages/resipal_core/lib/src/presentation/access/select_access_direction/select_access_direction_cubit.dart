import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class SelectAccessDirectionCubit extends Cubit<SelectAccessDirectionState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  SelectAccessDirectionCubit() : super(SelectAccessDirectionInitialState());

  Future onEntrySelected(InvitationEntity invitation) async {
    try {
      await LogAccessEvent().call(invitation, AccessLogDirection.entry);
      emit(SelectAccessDirectionLoggedSuccessfullyState(invitation: invitation));
    } catch (e, s) {
      _logger.error(featureArea: 'SelectAccessDirectionCubit', exception: e, stackTrace: s);
      emit(SelectAccessDirectionErrorState());
    }
  }

  Future onExitSelected(InvitationEntity invitation) async {
    try {
      await LogAccessEvent().call(invitation, AccessLogDirection.exit);
      emit(SelectAccessDirectionLoggedSuccessfullyState(invitation: invitation));
    } catch (e, s) {
      _logger.error(featureArea: 'SelectAccessDirectionCubit', exception: e, stackTrace: s);
      emit(SelectAccessDirectionErrorState());
    }
  }
}
