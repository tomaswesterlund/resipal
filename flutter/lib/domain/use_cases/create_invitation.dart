import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';

class CreateInvitation {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  Future call(CreateInvitationCommand command) async {
    await _source.createInvitation(
      userId: command.userId,
      propertyId: command.propertyId,
      visitorId: command.visitorId,
      fromDate: command.fromDate,
      toDate: command.toDate,
    );
  }
}

class CreateInvitationCommand {
  final String userId;
  final String propertyId;
  final String visitorId;
  final DateTime fromDate;
  final DateTime toDate;

  CreateInvitationCommand({
    required this.userId,
    required this.propertyId,
    required this.visitorId,
    required this.fromDate,
    required this.toDate,
  });
}
