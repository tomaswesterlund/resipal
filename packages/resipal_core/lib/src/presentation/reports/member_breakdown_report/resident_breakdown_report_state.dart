import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class ResidentBreakdownReportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResidentBreakdownReportInitialState extends ResidentBreakdownReportState {}
class ResidentBreakdownReportLoadingState extends ResidentBreakdownReportState {}
class ResidentBreakdownReportErrorState extends ResidentBreakdownReportState {}

class ResidentBreakdownReportLoadedState extends ResidentBreakdownReportState {
  final CommunityEntity community;
  final List<ResidentMemberEntity> residents;
  final int totalDebtCents;
  final int totalBalanceCents;
  final int totalPendingCents;

  ResidentBreakdownReportLoadedState({
    required this.community,
    required this.residents,
    required this.totalDebtCents,
    required this.totalBalanceCents,
    required this.totalPendingCents,
  });

  @override
  List<Object?> get props => [residents, totalDebtCents, totalBalanceCents, totalPendingCents];
}