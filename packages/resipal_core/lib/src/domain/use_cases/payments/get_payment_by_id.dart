import 'package:get_it/get_it.dart';
import 'package:resipal_core/src/data/sources/payment_data_source.dart';
import 'package:resipal_core/src/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/src/domain/enums/payment_status.dart';
import 'package:resipal_core/src/domain/use_cases/communities/get_community_ref_by_id.dart';
import 'package:resipal_core/src/domain/use_cases/users/get_user_ref_by_id.dart';

class GetPaymentById {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  PaymentEntity call(String id) {
    final model = _source.getById(id);

    final community = GetCommunityRefById().call(communityId: model.communityId);
    final user = GetUserRefById().call(userId: model.userId);
    final createdBy = GetUserRefById().call(userId: model.createdBy);

    return PaymentEntity(
      id: model.id,
      community: community,
      user: user,
      createdAt: model.createdAt,
      createdBy: createdBy,
      amountInCents: model.amountInCents,
      status: PaymentStatus.fromString(model.status),
      date: model.date,
      reference: model.reference,
      note: model.note,
      receiptPath: model.receiptPath,
    );
  }
}
