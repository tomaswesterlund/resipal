import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_contract_state.dart';
import 'register_contract_form_state.dart';

class RegisterContractCubit extends Cubit<RegisterContractState> {
  RegisterContractCubit() : super(FormEditingState(const RegisterContractFormState()));

  void updateName(String val) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      emit(FormEditingState(current.copyWith(name: val)));
    }
  }

  void updateAmount(String val) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      final doubleAmount = double.tryParse(val) ?? 0.0;
      emit(FormEditingState(current.copyWith(amount: doubleAmount)));
    }
  }

  void updateDescription(String val) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      emit(FormEditingState(current.copyWith(description: val)));
    }
  }

  Future<void> submit() async {
    if (state is! FormEditingState) return;
    final form = (state as FormEditingState).formState;
    if (!form.canSubmit) return;

    emit(FormSubmittingState());
    try {
      // TODO: Call your UseCase here
      // await _createContract.call(
      //   name: form.name,
      //   amountInCents: form.amountInCents,
      //   description: form.description,
      //   period: 'monthly',
      // );
      emit(FormSubmittedSuccessfullyState());
    } catch (e) {
      emit(ErrorState('Error al crear el contrato: $e'));
    }
  }
}