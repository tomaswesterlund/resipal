import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/use_cases/get_user_properties.dart';
import 'package:resipal/presentation/users/home/user_properties/user_properties_state.dart';

class UserPropertiesCubit extends Cubit<UserPropertiesState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  UserPropertiesCubit() : super(InitialState());

  Future intialize(String userId) async {
    try {
      emit(LoadingState());
      final properties = GetUserProperties().call(userId);
      emit(LoadedState(properties));
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserPropertiesCubit.intialize', stackTrace: s);
      emit(ErrorState());
    }
  }
}
