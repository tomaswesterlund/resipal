import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/entities/property_entity.dart';
import 'package:resipal/domain/repositories/property_repository.dart';
import 'package:resipal/presentation/users/home/user_properties/user_properties_state.dart';

class UserPropertiesCubit extends Cubit<UserPropertiesState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final PropertyRepository _propertyRepository = GetIt.I<PropertyRepository>();
  StreamSubscription<List<PropertyEntity>>? _streamSubscription;

  UserPropertiesCubit() : super(UserPropertiesState());

  Future intialize(String userId) async {
    try {
      await _streamSubscription?.cancel();
      emit(state.copyWith(isFetching: true));

      _streamSubscription = _propertyRepository
          .watchPropertiesByUserId(userId)
          .listen(
            (properties) {
              emit(UserPropertiesState(isFetching: false, properties: properties));
            },
            onError: (e, s) {
              _logger.logException(exception: e, featureArea: 'UserPropertiesCubit.intialize', stackTrace: s);
              emit(UserPropertiesState(errorMessage: e.toString(), exception: e));
            },
          );
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'UserPropertiesCubit.intialize', stackTrace: s);
      emit(UserPropertiesState(errorMessage: e.toString(), exception: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
