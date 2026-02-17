import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/ledger_entity.dart';

abstract class UserLedgerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserLedgerState {}

class LoadingState extends UserLedgerState {}

class LoadedState extends UserLedgerState {
  final LedgerEntity ledger;

  LoadedState(this.ledger);

  @override
  List<Object?> get props => [ledger];
}

class ErrorState extends UserLedgerState {}
