import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/repositories/movement_repository.dart';

class UserMovementsCubit extends Cubit<UserMovementsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final MovementRepository _movementRepository = GetIt.I<MovementRepository>();

  UserMovementsCubit() : super(InitialState());

  Future initialize(String userId) async {
    try {
      emit(LoadingState());
      _movementRepository.watchMovementsByUserId(userId).listen((movements) => emit(LoadedState(movements)), onError: (e) {});
    } catch (e, stack) {
      _logger.logException(exception: e, featureArea: 'UserMovementsCubit.initialize', stackTrace: stack);
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }
}

abstract class UserMovementsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends UserMovementsState {}

class LoadingState extends UserMovementsState {}

class LoadedState extends UserMovementsState {
  final List<MovementEntity> movements;

  LoadedState(this.movements);

  @override
  List<Object?> get props => [movements];
}

class ErrorState extends UserMovementsState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, this.exception});
}
