import 'package:equatable/equatable.dart';
import 'package:resipal_core/lib.dart';

abstract class ApplicationDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApplicationDetailsInitialState extends ApplicationDetailsState {}

class ApplicationDetailsLoadingState extends ApplicationDetailsState {}

class ApplicationDetailsLoadedState extends ApplicationDetailsState {
  final ApplicationEntity application;

  ApplicationDetailsLoadedState(this.application);

  @override
  List<Object?> get props => [application];
}

class ApplicationDetailsErrorState extends ApplicationDetailsState {}
