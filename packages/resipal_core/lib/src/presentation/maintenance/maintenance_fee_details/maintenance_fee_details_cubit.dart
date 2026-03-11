import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/maintenance/pay_maintenance_fee.dart';
import 'package:resipal_core/src/domain/use_cases/properties/get_property_member.dart';

class MaintenanceFeeDetailsCubit extends Cubit<MaintenanceFeeDetailsState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  // Assumes use case exists in your domain layer
  final WatchMaintenanceFeeById _watchFee = WatchMaintenanceFeeById();
  StreamSubscription? _streamSubscription;

  MaintenanceFeeDetailsCubit() : super(MaintenanceFeeDetailsInitialState());

  Future<void> initialize(MaintenanceFeeEntity fee) async {
    try {
      final member = GetPropertyMember().call(propertyId: fee.property.id);
      bool insufficientBalance = member.totalMemberBalanceInCents < fee.amountInCents;
      emit(MaintenanceFeeDetailsLoadedState(fee: fee, insufficientBalance: insufficientBalance));

      _streamSubscription = _watchFee
          .call(fee.id)
          .listen(
            (updatedFee) {
              bool insufficientBalance = member.totalMemberBalanceInCents < fee.amountInCents;
              emit(MaintenanceFeeDetailsLoadedState(fee: updatedFee, insufficientBalance: insufficientBalance));
            },
            onError: (e, s) {
              _logger.error(
                featureArea: 'MaintenanceFeeDetailsCubit.initialize',
                exception: e,
                stackTrace: s,
                metadata: {'feeId': fee.id},
              );
              emit(MaintenanceFeeDetailsErrorState());
            },
          );
    } catch (e, s) {
      _logger.error(
        exception: e,
        featureArea: 'MaintenanceFeeDetailsCubit.initialize',
        stackTrace: s,
        metadata: {'fee': fee.toMap()},
      );
      emit(MaintenanceFeeDetailsErrorState());
    }
  }

  Future payMaintenanceFee(MaintenanceFeeEntity fee) async {
    try {
      await PayMaintenanceFee().call(fee.id);
    } catch (e, s) {
      _logger.error(featureArea: 'MaintenanceFeeDetailsCubit.payMaintenanceFee', exception: e, stackTrace: s);
      emit(MaintenanceFeeDetailsErrorState());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
