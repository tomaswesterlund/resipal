import 'package:get_it/get_it.dart';
import 'package:resipal/data/sources/invitation_data_source.dart';
import 'package:resipal/domain/entities/invitation_entity.dart';
import 'package:resipal/domain/use_cases/get_property_ref.dart';
import 'package:resipal/domain/use_cases/get_visitor_ref.dart';

class GetInvitation {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  InvitationEntity call(String id) {
    final model = _source.getById(id);

    return InvitationEntity(
      id: id,
      userId: model.userId,
      visitor: GetVisitorRef().call(model.visitorId),
      property: GetPropertyRef().call(model.propertyId),
      createdAt: model.createdAt,
      qrCodeToken: model.qrCodeToken,
      fromDate: model.fromDate,
      toDate: model.toDate,
      maxEntries: model.maxEntries,
      logs: [],
    );
  }
}
