import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal/core/formatters/currency_formatter.dart';
import 'package:resipal/core/services/image_service.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/domain/repositories/payment_repository.dart';
import 'package:resipal/core/services/auth_service.dart';
import 'package:resipal/domain/repositories/user_repository.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_form_state.dart';
import 'package:resipal/presentation/payments/register_payment/register_payment_state.dart';

class RegisterPaymentCubit extends Cubit<RegisterPaymentState> {
  final ImageService _imageService = GetIt.I<ImageService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final AuthService _authService = GetIt.I<AuthService>();
  final UserRepository _userRepository = GetIt.I<UserRepository>();

  RegisterPaymentCubit() : super(InitialState());

  final PaymentRepository _paymentRepository = GetIt.I<PaymentRepository>();
  final ImagePicker _picker = ImagePicker();

  late RegisterPaymentFormState _formState;

  void initialize() {
    _formState = RegisterPaymentFormState(amount: 0.0, reference: '', note: '');
    emit(FormEditingState(_formState));
  }

  void updateAmount(double newValue) {
    _formState = _formState.copyWith(amount: newValue);
    emit(FormEditingState(_formState));
  }

  void updateReference(String newValue) {
    _formState = _formState.copyWith(reference: newValue);
    emit(FormEditingState(_formState));
  }

  void updateNote(String newValue) {
    _formState = _formState.copyWith(note: newValue);
    emit(FormEditingState(_formState));
  }

  Future submit() async {
    try {
      if (_formState.canSubmit == false) {
        emit(ErrorState());
        return;
      }

      emit(FormSubmittingState());

      final amountInCents = CurrencyFormatter.toAmountInCents(_formState.amount);

      final receiptPath = await _imageService.uploadPaymentReceipt(_formState.receiptImage!);

      await _paymentRepository.registerNewPayment(
        userId: _authService.getSignedInUserId(),
        amountInCents: amountInCents,
        date: DateTime.now(),
        reference: _formState.reference,
        note: _formState.note,
        receiptPath: receiptPath,
      );

      await _userRepository.fetchUser(_authService.getSignedInUserId());

      emit(FormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.logException(
        exception: e,
        stackTrace: s,
        featureArea: 'RegisterPaymentCubit.submit',
        metadata: _formState.toMap(),
      );
      emit(ErrorState());
    }
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);

      if (image != null) {
        _formState = _formState.copyWith(receiptImage: image);
        emit(FormEditingState(_formState));
      }
    } catch (e, stack) {
      await _logger.logException(
        exception: e,
        stackTrace: stack,
        featureArea: 'RegisterPaymentCubit.pickImage',
        metadata: {'source': source.toString(), 'device_time': DateTime.now().toIso8601String()},
      );

      emit(ErrorState());
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(receiptImage: null);
    emit(FormEditingState(_formState));
  }
}
