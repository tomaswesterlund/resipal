import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/extensions/formatters/currency_formatter.dart';

class MemberBreakdownReportCubit extends Cubit<MemberBreakdownReportState> {
  final SessionService _session = GetIt.I<SessionService>();

  MemberBreakdownReportCubit() : super(MemberBreakdownReportInitialState());

  void initialize() {
    emit(MemberBreakdownReportLoadingState());
    try {
      final communityId = _session.communityId;
      final community = GetCommunityById().call(communityId);
      final directory = community.memberDirectory;

      final totalDebt = directory.members.fold<int>(0, (sum, m) => sum + m.propertyRegistry.totalDebtAmountInCents);
      final totalBalance = directory.members.fold<int>(0, (sum, m) => sum + m.paymentLedger.totalPaymentBalanceInCents);

      // Calculate Pending Payments
      final totalPending = directory.members.fold<int>(
        0,
        (sum, m) => sum + m.paymentLedger.pendingPaymentAmountInCents,
      );

      emit(
        MemberBreakdownReportLoadedState(
          community: community,
          members: directory.members,
          totalDebtCents: totalDebt,
          totalBalanceCents: totalBalance,
          totalPendingCents: totalPending,
        ),
      );
    } catch (e) {
      emit(MemberBreakdownReportErrorState());
    }
  }
}
