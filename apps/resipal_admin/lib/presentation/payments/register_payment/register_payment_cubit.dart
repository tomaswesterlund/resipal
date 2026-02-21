import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/domain/entities/resident_entity.dart';
import 'register_payment_state.dart';
import 'register_payment_form_state.dart';

class RegisterPaymentCubit extends Cubit<RegisterPaymentState> {
  RegisterPaymentCubit() : super(FormEditingState(const RegisterPaymentFormState()));

  void updateResident(ResidentEntity? resident) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      emit(FormEditingState(current.copyWith(resident: resident)));
    }
  }

  void updateAmount(String val) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      final doubleAmount = double.tryParse(val) ?? 0.0;
      emit(FormEditingState(current.copyWith(amount: doubleAmount)));
    }
  }

  void updateReference(String val) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      emit(FormEditingState(current.copyWith(reference: val)));
    }
  }

  void updateNote(String val) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      emit(FormEditingState(current.copyWith(note: val)));
    }
  }

  void updateReceiptImage(XFile? file) {
    if (state is FormEditingState) {
      final current = (state as FormEditingState).formState;
      emit(FormEditingState(current.copyWith(receiptImage: file)));
    }
  }

  Future<void> submit() async {
    if (state is! FormEditingState) return;
    final form = (state as FormEditingState).formState;
    if (!form.canSubmit) return;

    emit(FormSubmittingState());
    try {
      // TODO: Call your UseCase here
      // await _registerPayment.call(
      //   residentId: form.resident!.id,
      //   amountInCents: form.amountInCents,
      //   reference: form.reference,
      //   note: form.note,
      //   imagePath: form.receiptImage?.path,
      // );
      emit(FormSubmittedSuccessfullyState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}