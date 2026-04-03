import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:core/lib.dart';

class RegisterPaymentCubit extends Cubit<RegisterPaymentState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final ImageService _imageService = GetIt.I<ImageService>();

  final ImagePicker _picker = ImagePicker();

  RegisterPaymentCubit() : super(RegisterPaymentInitialState());

  late RegisterPaymentFormState _formState;

  Future initialize(ResidentMemberEntity? resident) async {
    final resident = GetResidentByCommunityIdAndUserId().call(
      communityId: _sessionService.communityId,
      userId: _sessionService.userId,
    );

    if (_sessionService.app == ResipalApplication.admin) {
      final residents = GetResidentsByCommunity().call(_sessionService.communityId);

      if (residents.isEmpty) {
        emit(RegisterPaymentNoResidentsFound());
        return;
      }

      _formState = RegisterPaymentFormState(
        residents: residents,
        payDate: DateTime.now(),
        resident: null,
        isResidentReadOnly: false,
      );

      emit(RegisterPaymentFormEditingState(_formState));
      return;
    } else if (_sessionService.app == ResipalApplication.resident) {
      final resident = GetResidentByCommunityIdAndUserId().call(
        communityId: _sessionService.communityId,
        userId: _sessionService.userId,
      );

      _formState = RegisterPaymentFormState(
        residents: [resident],
        payDate: DateTime.now(),
        resident: resident,
        isResidentReadOnly: true,
      );

      emit(RegisterPaymentFormEditingState(_formState));
      return;
    } else {
      emit(RegisterPaymentErrorState());
      return;
    }
  }

  void updateResident(ResidentMemberEntity? newResident) {
    _formState = _formState.copyWith(resident: newResident);
    emit(RegisterPaymentFormEditingState(_formState));
  }

  void updateAmount(double newAmount) {
    _formState = _formState.copyWith(amount: newAmount);
    emit(RegisterPaymentFormEditingState(_formState));
  }

  void updatePayDate(DateTime? newPayDate) {
    _formState = _formState.copyWith(payDate: newPayDate);
    emit(RegisterPaymentFormEditingState(_formState));
  }

  void updateReference(String newReference) {
    _formState = _formState.copyWith(reference: newReference);
    emit(RegisterPaymentFormEditingState(_formState));
  }

  void updateNote(String newNote) {
    _formState = _formState.copyWith(note: newNote);
    emit(RegisterPaymentFormEditingState(_formState));
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);

      if (image != null) {
        _formState = _formState.copyWith(receiptImage: image);
        emit(RegisterPaymentFormEditingState(_formState));
      }
    } catch (e, stack) {
      await _logger.error(
        exception: e,
        stackTrace: stack,
        featureArea: 'RegisterPaymentCubit.pickImage',
        metadata: {'source': source.toString(), 'device_time': DateTime.now().toIso8601String()},
      );

      emit(RegisterPaymentErrorState());
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(receiptImage: null);
    emit(RegisterPaymentFormEditingState(_formState));
  }

  Future<void> submit() async {
    if (state is! RegisterPaymentFormEditingState) return;
    if (_formState.canSubmit == false) return;

    emit(RegisterPaymentFormSubmittingState());
    try {
      final imagePath = await _imageService.uploadPaymentReceipt(
        xFile: _formState.receiptImage!,
        communityId: _sessionService.communityId,
        residentId: _formState.resident!.user.id,
      );

      await RegisterPayment().call(
        residentId: _formState.resident!.user.id,
        amountInCents: _formState.amountInCents,
        date: _formState.payDate!,
        reference: _formState.reference,
        note: _formState.note,
        receiptPath: imagePath,
      );

      emit(RegisterPaymentFormSubmittedSuccessfullyState());
    } catch (e, s) {
      await _logger.error(
        exception: e,
        stackTrace: s,
        featureArea: 'RegisterPaymentCubit.submit',
        metadata: _formState.toMap(),
      );
      emit(RegisterPaymentErrorState());
    }
  }
}
