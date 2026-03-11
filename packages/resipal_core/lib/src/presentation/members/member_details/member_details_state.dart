import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class MemberDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MemberDetailsInitialState extends MemberDetailsState {}

class MemberDetailsLoadingState extends MemberDetailsState {}

class MemberDetailsLoadedState extends MemberDetailsState {
  final MemberEntity member;

  MemberDetailsLoadedState(this.member);

  @override
  List<Object?> get props => [member];
}

class MemberDetailsErrorState extends MemberDetailsState {}