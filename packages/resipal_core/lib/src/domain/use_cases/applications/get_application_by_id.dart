import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class GetApplicationById {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  ApplicationEntity call({required String id}) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Application withg id $id not found in cache. Ensure the stream is active.');
    }

    final community = GetCommunityRefById().call(communityId: model.communityId);
    final user = model.userId == null ? null : GetUserRefById().call(userId: model.userId!);

    return ApplicationEntity(
      id: model.id,
      community: community,
      user: user,
      createdAt: model.createdAt,
      createdBy: model.createdBy,
      name: model.name,
      phoneNumber: model.phoneNumber,
      emergencyPhoneNumber: model.emergencyPhoneNumber,
      email: model.email,
      status: ApplicationStatus.fromString(model.status),
      message: model.message,
      isAdmin: model.isAdmin,
      isResident: model.isResident,
      isSecurity: model.isSecurity,
    );
  }
}
