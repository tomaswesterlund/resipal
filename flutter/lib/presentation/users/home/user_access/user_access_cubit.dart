import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';

class UserAccessCubit extends Cubit<UserAccessState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  UserAccessCubit() : super(InitialState());

  Future initialize() async {
    try {
      // Get and listen to active invitations
    } catch (e, stack) {
      _logger.logException(
        exception: e,
        featureArea: 'UserAccessCubit.initialize',
        stackTrace: stack,
      );
      emit(ErrorState());
    }
  }
}

abstract class UserAccessState {}

class InitialState extends UserAccessState {}

class LoadingState extends UserAccessState {}

class LoadedState extends UserAccessState {
  final List<InvitationEntity> activeInvitations;

  LoadedState({required this.activeInvitations});
}

class ErrorState extends UserAccessState {

}
