import 'package:resipal_core/lib.dart';
import 'package:resipal_core/src/domain/use_cases/whatsapp/send_individual_whatsapp_message.dart';

class CreateApplicationAndSendInvitations {
  Future call(CreateApplicationDto dto) async {
    await CreateApplication().call(dto);
    await SendInvitationEmail().call(
      email: dto.email,
      name: dto.name,
      message: dto.message,
      communityId: dto.communityId,
    );
    await SendIndividualWhatsappMessage().call(
      phoneNumber: dto.phoneNumber,
      message: '!Hola! Favor de unir nuestra comunidad!',
    );
  }
}
