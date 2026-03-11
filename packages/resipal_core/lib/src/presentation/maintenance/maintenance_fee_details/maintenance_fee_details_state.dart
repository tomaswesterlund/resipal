import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class MaintenanceFeeDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MaintenanceFeeDetailsInitialState extends MaintenanceFeeDetailsState {}

class MaintenanceFeeDetailsLoadingState extends MaintenanceFeeDetailsState {}

class MaintenanceFeeDetailsLoadedState extends MaintenanceFeeDetailsState {
  final MaintenanceFeeEntity fee;
  final bool insufficientBalance;

  MaintenanceFeeDetailsLoadedState({required this.fee, required this.insufficientBalance});

  @override
  List<Object?> get props => [fee];
}

class MaintenanceFeeDetailsErrorState extends MaintenanceFeeDetailsState {}
