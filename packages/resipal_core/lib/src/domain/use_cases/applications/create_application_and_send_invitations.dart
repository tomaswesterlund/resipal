import 'package:resipal_core/lib.dart';

class CreateApplicationAndSendInvitations {
  Future call({
    required String communityId,
    required String? userId,
    required String name,
    required String email,
    required String phoneNumber,
    required String? emergencyPhoneNumber,
    required String status,
    required String message,
    required bool isAdmin,
    required bool isResident,
    required bool isSecurity,
  }) async {
    await CreateApplication().call(
      communityId: communityId,
      userId: userId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      emergencyPhoneNumber: emergencyPhoneNumber,
      status: status,
      message: message,
      isAdmin: isAdmin,
      isResident: isResident,
      isSecurity: isSecurity,
    );

    await SendInvitationEmail().call(email: email, name: name, message: message, communityId: communityId);
    await SendIndividualWhatsappMessage().call(
      phoneNumber: phoneNumber,
      message: '!Hola! Favor de unir nuestra comunidad!',
    );
  }
}
