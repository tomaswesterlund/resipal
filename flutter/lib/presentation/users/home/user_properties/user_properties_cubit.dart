import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/presentation/users/home/user_properties/user_properties_state.dart';

class UserPropertiesCubit extends Cubit<UserPropertiesState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PropertyRepository _propertyRepository = GetIt.I<PropertyRepository>();

  UserPropertiesCubit() : super(InitialState());

  Future intialize(String userId) async {
    try {
      emit(LoadingState());
      final properties = await _propertyRepository.getPropertiesByOwnerId(userId);
      emit(LoadedState(properties));
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserPropertiesCubit.intialize', stackTrace: s);
      emit(ErrorState());
    }
  }

}
