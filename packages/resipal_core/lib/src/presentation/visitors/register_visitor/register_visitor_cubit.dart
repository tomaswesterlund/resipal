import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal_core/lib.dart';
import 'package:wester_kit/lib.dart';

class RegisterVisitorCubit extends Cubit<RegisterVisitorState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();
  final ImageService _imageService = GetIt.I<ImageService>();
  final ImagePicker _picker = ImagePicker();

  RegisterVisitorFormState _formState = RegisterVisitorFormState(
    name: InputField<String>(value: '', validators: [ValueNotEmpty()]),
    image: InputField<XFile?>(value: null, validators: [XFileNotNull(errorText: 'Identificación obligatoria.')]),
  );

  RegisterVisitorCubit() : super(RegisterVisitorInitialState());

  void initialize() {
    emit(RegisterVisitorFormEditingState(_formState));
  }

  void updateName(String newName) {
    final name = _formState.name.copyWith(value: newName);
    _formState = _formState.copyWith(name: name);
    emit(RegisterVisitorFormEditingState(_formState));
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? xFile = await _picker.pickImage(source: source, imageQuality: 70);
      if (xFile != null) {
        final image = _formState.image.copyWith(value: xFile);
        _formState = _formState.copyWith(image: image);
        emit(RegisterVisitorFormEditingState(_formState));
      }
    } catch (e, stack) {
      _logger.error(exception: e, stackTrace: stack, featureArea: 'RegisterVisitorCubit.pickImage');
      emit(RegisterVisitorErrorState());
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(image: null);
    emit(RegisterVisitorFormEditingState(_formState));
  }

  Future<void> submit() async {
    final state = _formState.validate();
    if (state.isValid == false) {
      emit(RegisterVisitorFormEditingState(state));
      return;
    }

    emit(RegisterVisitorSubmittingState());
    try {
      final idImagePath = await _imageService.uploadVisitorIdentification(
        xFile: _formState.image.value!,
        communityId: _sessionService.communityId,
        residentId: _sessionService.userId,
      );

      await RegisterVisitor().call(
        communityId: _sessionService.communityId,
        userId: _sessionService.userId,
        name: state.name.value,
        identificationImagePath: idImagePath,
      );

      emit(RegisterVisitorSuccessState());
    } catch (e, s) {
      _logger.error(exception: e, stackTrace: s, featureArea: 'RegisterVisitorCubit.submit', metadata: state.toMap());
      emit(RegisterVisitorErrorState());
    }
  }
}
