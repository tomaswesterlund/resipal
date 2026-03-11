import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:wester_kit/extensions/formatters/currency_formatter.dart';
import 'register_contract_state.dart';
import 'register_contract_form_state.dart';
import 'package:resipal_core/lib.dart';

class RegisterContractCubit extends Cubit<RegisterContractState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  RegisterContractCubit() : super(RegisterContractFormEditingState(const RegisterContractFormState()));

  void updateName(String val) {
    if (state is RegisterContractFormEditingState) {
      final current = (state as RegisterContractFormEditingState).formState;
      emit(RegisterContractFormEditingState(current.copyWith(name: val)));
    }
  }

  void updateAmount(String val) {
    if (state is RegisterContractFormEditingState) {
      final current = (state as RegisterContractFormEditingState).formState;
      final doubleAmount = double.tryParse(val) ?? 0.0;
      emit(RegisterContractFormEditingState(current.copyWith(amount: doubleAmount)));
    }
  }

  void updateDescription(String val) {
    if (state is RegisterContractFormEditingState) {
      final current = (state as RegisterContractFormEditingState).formState;
      emit(RegisterContractFormEditingState(current.copyWith(description: val)));
    }
  }

  Future submit() async {
    if (state is! RegisterContractFormEditingState) return;
    final form = (state as RegisterContractFormEditingState).formState;
    if (!form.canSubmit) return;

    emit(RegisterContractFormSubmittingState());
    try {
      final contractId = await CreateContract().call(
        communityId: _sessionService.communityId,
        name: form.name,
        amountInCents: CurrencyFormatter.toAmountInCents(form.amount),
        period: 'monthly',
        description: form.description,
      );

      await FetchContract().call(contractId);


      emit(RegisterContractFormSubmittedSuccessfullyState());
    } catch (e, s) {
      emit(RegisterContractErrorState());
      _logger.error(
        exception: e,
        stackTrace: s,
        featureArea: 'RegisterContractCubit.submit',
      );
    }
  }
}
