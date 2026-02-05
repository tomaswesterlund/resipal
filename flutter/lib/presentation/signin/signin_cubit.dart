import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/domain/entities/user_entity.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/presentation/signin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthService _sessionService = GetIt.I<AuthService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final UserRepository _userRepository = GetIt.I<UserRepository>();

  SigninCubit() : super(InitialState());

  Future signin() async {
    try {
      await _sessionService.signInWithGoogle();
      final authUser = _sessionService.getSignedInUser()!;

      // Has the user been onboarded i.e. exists in the Users table?
      final userOnboarded = await _userRepository.userExists(authUser.id);

      if (userOnboarded) {
        final user = _userRepository.getUserById(authUser.id);
        emit(UserSignedInSuccessfullyState(userOnboarded: true, user: user));
      } else {
        emit(UserSignedInSuccessfullyState(userOnboarded: false));
      }
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
