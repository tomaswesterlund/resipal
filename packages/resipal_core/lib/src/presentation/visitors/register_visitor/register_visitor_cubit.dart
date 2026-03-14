import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/visitors/register_visitor.dart';
import 'register_visitor_state.dart';
import 'register_visitor_form_state.dart';

class RegisterVisitorCubit extends Cubit<RegisterVisitorState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final ImageService _imageService = GetIt.I<ImageService>();
  final ImagePicker _picker = ImagePicker();

  late RegisterVisitorFormState _formState;

  RegisterVisitorCubit() : super(RegisterVisitorInitialState());

  void initialize() {
    _formState = const RegisterVisitorFormState();
    emit(RegisterVisitorFormEditingState(_formState));
  }

  void updateName(String name) {
    _formState = _formState.copyWith(name: name);
    emit(RegisterVisitorFormEditingState(_formState));
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);
      if (image != null) {
        _formState = _formState.copyWith(idImage: image);
        emit(RegisterVisitorFormEditingState(_formState));
      }
    } catch (e, stack) {
      _logger.error(exception: e, stackTrace: stack, featureArea: 'RegisterVisitorCubit.pickImage');
      emit(RegisterVisitorErrorState());
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(idImage: null);
    emit(RegisterVisitorFormEditingState(_formState));
  }

  Future<void> submit() async {
    if (_formState.canSubmit == false) return;

    emit(RegisterVisitorSubmittingState());
    try {
      final idImagePath = await _imageService.uploadVisitorIdentification(
        xFile: _formState.idImage!,
        communityId: _sessionService.communityId,
        residentId: _sessionService.userId,
      );

      await RegisterVisitor().call(
        communityId: _sessionService.communityId,
        userId: _sessionService.userId,
        name: _formState.name,
        identificationImagePath: idImagePath,
      );

      emit(RegisterVisitorSuccessState());
    } catch (e, s) {
      _logger.error(
        exception: e,
        stackTrace: s,
        featureArea: 'RegisterVisitorCubit.submit',
        metadata: _formState.toMap(),
      );
      emit(RegisterVisitorErrorState());
    }
  }
}
