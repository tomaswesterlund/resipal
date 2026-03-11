import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class MemberBreakdownReportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemberBreakdownReportInitialState extends MemberBreakdownReportState {}
class MemberBreakdownReportLoadingState extends MemberBreakdownReportState {}
class MemberBreakdownReportErrorState extends MemberBreakdownReportState {}

class MemberBreakdownReportLoadedState extends MemberBreakdownReportState {
  final CommunityEntity community;
  final List<MemberEntity> members;
  final int totalDebtCents;
  final int totalBalanceCents;
  final int totalPendingCents; // Added field

  MemberBreakdownReportLoadedState({
    required this.community,
    required this.members,
    required this.totalDebtCents,
    required this.totalBalanceCents,
    required this.totalPendingCents,
  });

  @override
  List<Object?> get props => [members, totalDebtCents, totalBalanceCents, totalPendingCents];
}