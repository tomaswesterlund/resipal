import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';

class ContractsCubit extends Cubit<ContractsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

  ContractsCubit() : super(ContractsInitialState());

  StreamSubscription? _streamSubscription;

  initialize(List<ContractEntity> contracts) {
    try {
      emit(ContractsLoadedState(contracts));
      _streamSubscription = WatchContractsByCommunity()
          .call(_sessionService.communityId)
          .listen(
            (contracts) => emit(ContractsLoadedState(contracts)),
            onError: (e, s) {
              _logger.error(featureArea: 'ContractsCubit', exception: e, stackTrace: s);
              emit(ContractsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(featureArea: 'ContractsCubit', exception: e, stackTrace: s);
      emit(ContractsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
