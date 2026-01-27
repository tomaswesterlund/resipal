import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/repositories/user_repository.dart';

class SigninCubit extends Cubit<SigninState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final UserRepository _userRepository = GetIt.I<UserRepository>();

  SigninCubit() : super(InitialState());

  Future signin() async {
    try {
      // Signin logic
      final user = await _userRepository.getUserById(
        'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',
      );

      // Set signin user

      emit(UserSignedInSuccessfullyState(user));
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        stackTrace: stack,
        featureArea: 'SigninCubit.signin',
      );
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }
}

abstract class SigninState {}

class InitialState extends SigninState {}

class UserSignedInSuccessfullyState extends SigninState {
  final UserEntity user;

  UserSignedInSuccessfullyState(this.user);
}

class ErrorState extends SigninState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, required this.exception});
}
