import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/payment_data_source.dart';
import 'package:resipal_core/domain/entities/payment/payment_entity.dart';
import 'package:resipal_core/domain/enums/payment_status.dart';
import 'package:resipal_core/domain/use_cases/communities/get_community_ref.dart';
import 'package:resipal_core/domain/use_cases/get_user_ref.dart';

class GetPaymentById {
  final PaymentDataSource _source = GetIt.I<PaymentDataSource>();

  PaymentEntity call(String id) {
    final model = _source.getById(id);

    final community = GetCommunityRef().fromId(model.communityId);
    final user = GetUserRef().fromId(model.userId);
    final createdBy = GetUserRef().fromId(model.createdBy);

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
