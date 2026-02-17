import 'package:equatable/equatable.dart';
import 'package:resipal_core/domain/entities/user_entity.dart';

class UserHomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserHomeState {}

class LoadingState extends UserHomeState {}

class LoadedState extends UserHomeState {
  final UserEntity user;

  LoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class ErrorState extends UserHomeState {}
