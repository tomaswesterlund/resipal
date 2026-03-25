import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:core/lib.dart';

class ResidentBreakdownReportCubit extends Cubit<ResidentBreakdownReportState> {
  final SessionService _session = GetIt.I<SessionService>();

  ResidentBreakdownReportCubit() : super(ResidentBreakdownReportInitialState());

  void initialize() {
    emit(ResidentBreakdownReportLoadingState());
    try {
      final communityId = _session.communityId;
      final community = GetCommunityById().call(communityId);
      final residents = GetResidentsByCommunity().call(communityId);

      final totalDebt = residents.fold<int>(0, (sum, m) => sum + m.propertyRegistry.totalDebtAmountInCents);
      final totalBalance = residents.fold<int>(0, (sum, m) => sum + m.paymentLedger.totalPaymentBalanceInCents);

      // Calculate Pending Payments
      final totalPending = residents.fold<int>(0, (sum, m) => sum + m.paymentLedger.pendingPaymentAmountInCents);

      emit(
        ResidentBreakdownReportLoadedState(
          community: community,
          residents: residents,
          totalDebtCents: totalDebt,
          totalBalanceCents: totalBalance,
          totalPendingCents: totalPending,
        ),
      );
    } catch (e) {
      emit(ResidentBreakdownReportErrorState());
    }
  }
}
