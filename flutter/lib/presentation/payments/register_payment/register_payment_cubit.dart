import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/services/image_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/core/services/session_service.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_form_state.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_state.dart';

class RegisterPaymentCubit extends Cubit<RegisterPaymentState> {
  final ImageService _imageService = GetIt.I<ImageService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final SessionService _sessionService = GetIt.I<SessionService>();

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

  void initialize() {
    _formState = RegisterPaymentFormState(amount: 0.0, reference: '', note: '');

    _amountController.addListener(_updateAmount);
    _referenceController.addListener(() => _updateReference());
    _noteController.addListener(() => _updateNote());

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

  void _updateReference() {
    _formState = _formState.copyWith(reference: _referenceController.text);
    emit(FormEditingState(_formState));
  }

  void _updateNote() {
    _formState = _formState.copyWith(note: _noteController.text);
    emit(FormEditingState(_formState));
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

      final receiptPath = await _imageService.uploadReceipt(
        _formState.receiptImage!,
        _sessionService.getSignedInUserId(),
      );

      await _paymentRepository.registerNewPayment(
        userId: _sessionService.getSignedInUserId(),
        amountInCents: amountInCents,
        date: DateTime.now(),
        reference: _formState.reference,
        note: _formState.note,
        receiptPath: receiptPath,
      );

      emit(FormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.logException(
        exception: e,
        stackTrace: s,
        featureArea: 'RegisterPaymentCubit.submit',
        metadata: _formState.toMap(),
      );
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
