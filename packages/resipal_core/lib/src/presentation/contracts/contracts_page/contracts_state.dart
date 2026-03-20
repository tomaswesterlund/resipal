import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

class ContractsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContractsInitialState extends ContractsState {}

class ContractsLoadedState extends ContractsState {
  final List<ContractEntity> contracts;

  ContractsLoadedState(this.contracts);

  @override
  List<Object?> get props => [contracts];
}

class ContractsErrorState extends ContractsState {}