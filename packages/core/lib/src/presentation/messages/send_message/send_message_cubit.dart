import 'package:core/src/domain/use_cases/messages/send_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:core/lib.dart';
import 'package:ui/lib.dart';
import 'send_message_form_state.dart';
import 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SessionService _sessionService = GetIt.I<SessionService>();
  final LoggerService _logger = GetIt.I<LoggerService>();

  SendMessageCubit() : super(SendMessageInitialState());

  SendMessageFormState _formState = SendMessageFormState(
    members: [],
    selectedMember: InputField<MemberEntity?>(value: null, validators: [ValueNotNull()]),
    title: InputField(value: '', validators: [ValueNotEmpty()]),
    body: InputField(value: '', validators: [ValueNotEmpty()]),
  );

  void initialize() {
    final members = GetMembersByCommunityId().call(communityId: _sessionService.communityId);
    _formState = _formState.copyWith(members: members);
    emit(SendMessageFormEditingState(_formState));
  }

  void updateMember(MemberEntity? member) {
    final selectedMember = _formState.selectedMember.copyWith(value: member, clearError: true);
    _formState = _formState.copyWith(selectedMember: selectedMember);
    emit(SendMessageFormEditingState(_formState));
  }

  void updateTitle(String newTitle) {
    final title = _formState.title.copyWith(value: newTitle, clearError: true);
    _formState = _formState.copyWith(title: title);
    emit(SendMessageFormEditingState(_formState));
  }

  void updateBody(String newBody) {
    final body = _formState.body.copyWith(value: newBody, clearError: true);
    _formState = _formState.copyWith(body: body);
    emit(SendMessageFormEditingState(_formState));
  }

  Future<void> submit() async {
    final state = _formState.validate();
    if (state.isValid == false) {
      emit(SendMessageFormEditingState(state));
      return;
    }

    emit(SendMessageSubmittingState());

    try {
      await SendMessage().call(
        communityId: _sessionService.communityId,
        userId: state.selectedMember.value!.user.id,
        app: _sessionService.app,
        title: state.title.value,
        body: state.body.value,
      );
      emit(SendMessageSuccessState());
    } catch (e, s) {
      await _logger.error(exception: e, stackTrace: s, featureArea: 'SendMessageCubit.submit');
      emit(SendMessageErrorState());
    }
  }
}
