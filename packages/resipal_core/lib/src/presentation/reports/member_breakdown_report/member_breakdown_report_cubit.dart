import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

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
