import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/models/invitation_model.dart';
import 'package:resipal_core/data/sources/invitation_data_source.dart';
import 'package:resipal_core/domain/entities/invitation_entity.dart';
import 'package:resipal_core/domain/use_cases/properties/get_property_ref.dart';
import 'package:resipal_core/domain/use_cases/get_visitor_ref.dart';

class GetInvitation {
  final InvitationDataSource _source = GetIt.I<InvitationDataSource>();

  final _getVisitorRef = GetVisitorRef();
  final _getPropertyRef = GetPropertyRef();

  InvitationEntity fromId(String id) {
    final model = _source.getById(id);

    if (model == null) {
      throw Exception('Invitation $id not found in cache. Ensure the stream is active.');
    }

    return fromModel(model);
  }

  InvitationEntity fromModel(InvitationModel model) {
    return InvitationEntity(
      id: model.id,
      userId: model.userId,
      visitor: _getVisitorRef.fromId(model.visitorId),
      property: _getPropertyRef(model.propertyId),
      createdAt: model.createdAt,
      qrCodeToken: model.qrCodeToken,
      fromDate: model.fromDate,
      toDate: model.toDate,
      maxEntries: model.maxEntries,
      logs: [],
    );
  }
}
