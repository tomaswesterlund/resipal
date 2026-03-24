import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class AcceptApplication {
  final LoggerService _logger = GetIt.I<LoggerService>();
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future call({required ApplicationEntity application, required String userId}) async {
    if (application.status != ApplicationStatus.invited) {
      final errorMessage = 'Application with id ${application.id} for userId ${userId} not in status invited.';
      _logger.error(featureArea: 'AcceptApplication', exception: errorMessage);
      throw Exception(errorMessage);
    }

    final upsert = UpsertApplicationModel(
      id: application.id,
      userId: userId,
      communityId: application.community.id,
      name: application.name,
      phoneNumber: application.phoneNumber,
      emergencyPhoneNumber: application.emergencyPhoneNumber,
      email: application.email,
      status: ApplicationStatus.approved.toString(),
      message: application.message,
      isAdmin: application.isAdmin,
      isResident: application.isResident,
      isSecurity: application.isSecurity,
    );

    await _source.upsert(upsert);
    await CreateMembership().call(
      communityId: application.community.id,
      userId: userId,
      isAdmin: application.isAdmin,
      isResident: application.isResident,
      isSecurity: application.isSecurity,
    );
  }
}
