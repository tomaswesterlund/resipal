import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/domain/entities/contract_entity.dart';
import 'package:resipal_core/services/logger_service.dart';
import 'contract_list_state.dart';

class ContractListCubit extends Cubit<ContractListState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  // Assuming a GetContracts use case exists or similar logic
  // final GetContracts _getContracts = GetIt.I<GetContracts>();

  ContractListCubit() : super(InitialState());

  Future<void> initialize() async {
    try {
      emit(LoadingState());
      
      // Simulate API call or replace with actual use case
      // final contracts = await _getContracts.call();
      final contracts = <ContractEntity>[]; // Placeholder

      if (contracts.isEmpty) {
        emit(EmptyState());
      } else {
        emit(LoadedState(contracts));
      }
    } catch (e, s) {
      _logger.logException(
        exception: e,
        stackTrace: s,
        featureArea: 'ContractListCubit.initialize',
      );
      emit(ErrorState('No se pudieron cargar los contratos'));
    }
  }
}