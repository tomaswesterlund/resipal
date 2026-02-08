import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resipal/core/services/logger_service.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_form_state.dart';
import 'package:resipal/presentation/visitors/create_visitor/create_visitor_state.dart';

class CreateVisitorCubit extends Cubit<CreateVisitorState> {
  final LoggerService _logger = GetIt.I<LoggerService>();

  final ImagePicker _picker = ImagePicker();
  late CreateVisitorFormState _formState;

  CreateVisitorCubit() : super(InitialState());

  Future initialize() async {
    try {
      emit(LoadingState());
      _formState = CreateVisitorFormState();
      emit(FormEditingState(_formState));
    } catch (e, s) {
      _logger.logException(exception: e, featureArea: 'CreateVisitorCubit.initialize', stackTrace: s);
      emit(ErrorState());
    }
  }

  void updateName(String name) {
    _formState = _formState.copyWith(name: name);
    emit(FormEditingState(_formState));
  }

  void pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, imageQuality: 70);

      if (image != null) {
        _formState = _formState.copyWith(identificationImage: image);
        emit(FormEditingState(_formState));
      }
    } catch (e, stack) {
      await _logger.logException(
        exception: e,
        stackTrace: stack,
        featureArea: 'CreateVisitorCubit.pickImage',
        metadata: {'source': source.toString(), 'device_time': DateTime.now().toIso8601String()},
      );

      emit(ErrorState());
    }
  }

  void removeImage() {
    _formState = _formState.copyWith(identificationImage: null);
    emit(FormEditingState(_formState));
  }

  Future submit() async {
    try {
      if (_formState.isValid() == false) {
        emit(ErrorState());
        return;
      }

      emit(FormSubmittingState());
    } catch (e, s) {
      await _logger.logException(
        exception: e,
        stackTrace: s,
        featureArea: 'CreateVisitorCubit.submit',
        metadata: _formState.toMap(),
      );
      emit(ErrorState());
    }
  }
}
