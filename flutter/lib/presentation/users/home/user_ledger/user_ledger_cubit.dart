// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:resipal/core/services/logger_service.dart';
// import 'package:resipal/domain/entities/ledger_entity.dart';
// import 'package:resipal/domain/repositories/ledger_repository.dart';
// import 'package:resipal/presentation/users/home/user_ledger/user_ledger_state.dart';

// class UserLedgerCubit extends Cubit<UserLedgerState> {
//   final LoggerService _logger = GetIt.I<LoggerService>();
//   final LedgerRepository _ledgerRepository = GetIt.I<LedgerRepository>();

//   UserLedgerCubit() : super(InitialState());

//   Future intialize(String userId) async {
//     try {
//       emit(LoadingState());
//       final ledger = await _ledgerRepository.getLedgerByUserId(userId);
//       emit(LoadedState(ledger));
//     } catch (e, s) {
//       _logger.logException(exception: e, featureArea: 'UserLedgerCubit.intialize', stackTrace: s);
//       emit(ErrorState());
//     }
//   }
// }
