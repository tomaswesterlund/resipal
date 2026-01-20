import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/domain/entities/movement_entity.dart';
import 'package:resipal/domain/repositories/movement_repository.dart';

class UserMovementsCubit extends Cubit<UserMovementsState> {
  final MovementRepository _movementRepository = GetIt.I<MovementRepository>();

  UserMovementsCubit() : super(InitialState());

  Future load() async {
    try {
      emit(LoadingState());
      final movements = await _movementRepository.getMovementsByUserId('');
      emit(LoadedState(movements));
    }
    catch (e) {
      emit(ErrorState(message: e.toString(), exception: e));
    }
  }
}

abstract class UserMovementsState {}

class InitialState extends UserMovementsState {}

class LoadingState extends UserMovementsState {}

class LoadedState extends UserMovementsState {
  final List<MovementEntity> movements;

  LoadedState(this.movements);
}

class ErrorState extends UserMovementsState {
  final String message;
  final Object exception;

  ErrorState({required this.message, required this.exception});
}
