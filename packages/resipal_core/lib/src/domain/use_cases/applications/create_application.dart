import 'package:get_it/get_it.dart';
import 'package:resipal_core/lib.dart';

class CreateApplication {
  final ApplicationDataSource _source = GetIt.I<ApplicationDataSource>();

  Future<ApplicationId> call({
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
    final model = UpsertApplicationModel(userId: userId, communityId: communityId, name: name, phoneNumber: phoneNumber, emergencyPhoneNumber: emergencyPhoneNumber, email: email, status: status, message: message, isAdmin: isAdmin, isResident: isResident, isSecurity: isSecurity);
    return _source.upsert(model);
  }
}

