import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:core/src/presentation/access/scan_invitation/scan_invitation_state.dart';
import 'package:core/src/services/logger_service.dart';

class ScanInvitationCubit extends Cubit<ScanInvitationState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  ScanInvitationCubit() : super(ScanInvitationInitialState());

  Future onQrCodeScanned(String qrCodeToken) async {
    try {
      final invitation = await GetOptionalInvitationByQrCodeToken().call(qrCodeToken: qrCodeToken);

      if (invitation == null) {
        emit(ScanInvitationQrCodeNotValidState());
        return;
      }

      emit(ScanInvitationQrCodeValidState(invitation: invitation));
    } catch (e, s) {
      _logger.error(featureArea: 'ScanInvitationCubit', exception: e, stackTrace: s);
      emit(ScanInvitationErrorState());
    }
  }
}
