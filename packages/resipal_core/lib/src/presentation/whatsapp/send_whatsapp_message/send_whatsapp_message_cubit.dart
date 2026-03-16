import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/whatsapp/send_individual_whatsapp_message.dart';
import 'send_whatsapp_message_state.dart';
import 'send_whatsapp_message_form_state.dart';

class SendWhatsappMessageCubit extends Cubit<SendWhatsappMessageState> {
  final LoggerService _logger = GetIt.I<LoggerService>();
  // Supongamos que tienes un servicio para llamar a Edge Functions
  // final SupabaseService _supabase = GetIt.I<SupabaseService>();

  SendWhatsappMessageCubit() : super(SendWhatsappMessageInitialState());

  late SendWhatsappMessageFormState _formState;

  void initialize() {
    _formState = const SendWhatsappMessageFormState();
    emit(SendWhatsappMessageFormEditingState(_formState));
  }

  void updatePhoneNumber(String value) {
    _formState = _formState.copyWith(phoneNumber: value);
    emit(SendWhatsappMessageFormEditingState(_formState));
  }

  void updateMessage(String value) {
    _formState = _formState.copyWith(message: value);
    emit(SendWhatsappMessageFormEditingState(_formState));
  }

  Future<void> submit() async {
    try {
      if (!_formState.canSubmit) return;

      emit(SendWhatsappMessageSubmittingState());

      final cleanPhone = _formState.phoneNumber.replaceAll(RegExp(r'\D'), '');
      await SendIndividualWhatsappMessage().call(phoneNumber: cleanPhone, message: _formState.message);

      emit(SendWhatsappMessageSuccessState());
    } catch (e, s) {
      await _logger.error(exception: e, stackTrace: s, featureArea: 'SendWhatsappMessageCubit.submit');
      emit(SendWhatsappMessageErrorState(error: e.toString()));
    }
  }
}

