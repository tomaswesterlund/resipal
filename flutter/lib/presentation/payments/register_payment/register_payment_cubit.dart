import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPaymentCubit extends Cubit<RegisterPaymentState> {
  RegisterPaymentCubit() : super(InitialState());

  final TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;

  final TextEditingController _referenceController = TextEditingController();
  TextEditingController get referenceController => _referenceController;

  final TextEditingController _noteController = TextEditingController();
  TextEditingController get noteController => _noteController;

  late RegisterPaymentFormState _formState;

  void setup() {
    _formState = RegisterPaymentFormState(amount: 0.0, reference: '', note: '');

    _amountController.addListener(_updateAmount);

    emit(FormEditingState(_formState));
  }

  void _updateAmount() {
    try {
      if (_amountController.text.isEmpty) return;

      final strValue = _amountController.text;
      final double? amount = double.tryParse(strValue);
      if (amount == null) {
        emit(ErrorState(errorMessage: 'Amount could not be parsed.'));
      } else {
        _formState = _formState.copyWith(amount: amount);
        emit(FormEditingState(_formState));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }

  void submit() {
    try {
      emit(FormSubmittingState());
    }
    catch (e) {
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }

  @override
  Future<void> close() {
    _amountController.dispose();
    _referenceController.dispose();
    _noteController.dispose();
    return super.close();
  }
}

abstract class RegisterPaymentState {}

class InitialState extends RegisterPaymentState {}

class FormEditingState extends RegisterPaymentState {
  final RegisterPaymentFormState formState;

  FormEditingState(this.formState);
}

class FormSubmittingState extends RegisterPaymentState {}

class ErrorState extends RegisterPaymentState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, this.exception});
}

class RegisterPaymentFormState extends Equatable {
  final double amount;
  final String reference;
  final String note;

  bool get canSubmit {
    if (amount <= 0) return false;
    // if (reference.isEmpty) return false;
    // if (note.isEmpty) return false;

    return true;
  }

  const RegisterPaymentFormState({
    required this.amount,
    required this.reference,
    required this.note,
  });

  RegisterPaymentFormState copyWith({
    double? amount,
    String? reference,
    String? note,
  }) {
    return RegisterPaymentFormState(
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [amount, reference, note];
}
