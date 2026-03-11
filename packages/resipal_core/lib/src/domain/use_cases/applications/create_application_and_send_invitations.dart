import 'package:resipal_core/lib.dart';

class CreateApplicationAndSendInvitations {
  Future call(CreateApplicationDto dto) async {
    await CreateApplication().call(dto);
    await SendInvitationEmail().call(
      email: dto.email,
      name: dto.name,
      message: dto.message,
      communityId: dto.communityId,
    );
    // Send WhatsApp
  }
}
