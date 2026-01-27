import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/services/image_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/core/services/session_service.dart';

class RegisterPaymentCubit extends Cubit<RegisterPaymentState> {
  final ImageService _imageService = GetIt.I<ImageService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  RegisterPaymentCubit() : super(InitialState());

  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();

  final TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;

  final TextEditingController _referenceController = TextEditingController();
  TextEditingController get referenceController => _referenceController;

  final TextEditingController _noteController = TextEditingController();
  TextEditingController get noteController => _noteController;

  final ImagePicker _picker = ImagePicker();

  late RegisterPaymentFormState _formState;

  void setup() {
    _formState = RegisterPaymentFormState(amount: 0.0, reference: '', note: '');

    _amountController.addListener(_updateAmount);
    _referenceController.addListener(
      () => _formState = _formState.copyWith(
        reference: _referenceController.text,
      ),
    );
    _noteController.addListener(
      () => _formState = _formState.copyWith(note: _noteController.text),
    );

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

  Future submit() async {
    try {
      if (_formState.canSubmit == false) {
        emit(ErrorState(errorMessage: 'Form state is not valid'));
        return;
      }

      emit(FormSubmittingState());

      final amountInCents = CurrencyFormatter.toAmountInCents(
        _formState.amount,
      );

      final receiptPath = await _imageService.uploadReceipt(_formState.receiptImage!, SessionService.signedInUserId);

      await _paymentRepository.registerNewPayment(
        userId: SessionService.signedInUserId,
        amountInCents: amountInCents,
        date: DateTime.now(),
        reference: _formState.reference,
        note: _formState.note,
        receiptPath: receiptPath
      );

      emit(FormSubmittedSuccessfully());
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString(), exception: e));
    }
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image != null) {
        _formState = _formState.copyWith(receiptImage: image);
        emit(FormEditingState(_formState));
      }
    } catch (e, stack) {
      await _logger.logException(
        exception: e,
        stackTrace: stack,
        featureArea: 'RegisterPaymentCubit.pickImage',
        metadata: {
          'source': source.toString(),
          'device_time': DateTime.now().toIso8601String(),
        },
      );

      emit(
        ErrorState(
          errorMessage:
              'Error al seleccionar la imagen. Por favor intenta de nuevo.',
          exception: e,
        ),
      );
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(receiptImage: null);
    emit(FormEditingState(_formState));
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

class FormSubmittedSuccessfully extends RegisterPaymentState {}

class ErrorState extends RegisterPaymentState {
  final String errorMessage;
  final Object? exception;

  ErrorState({required this.errorMessage, this.exception});
}

class RegisterPaymentFormState extends Equatable {
  final double amount;
  final String reference;
  final String note;
  final XFile? receiptImage;

  bool get canSubmit {
    if (amount <= 0) return false;
    if (receiptImage == null) return false;

    return true;
  }

  const RegisterPaymentFormState({
    required this.amount,
    required this.reference,
    required this.note,
    this.receiptImage,
  });

  RegisterPaymentFormState copyWith({
    double? amount,
    String? reference,
    String? note,
    XFile? receiptImage,
  }) {
    return RegisterPaymentFormState(
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      receiptImage: receiptImage ?? this.receiptImage,
    );
  }

  @override
  List<Object?> get props => [amount, reference, note, receiptImage];
}
