import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/domain/entities/community/community_directory_entity.dart';
import 'package:resipal_core/domain/entities/community/community_entity.dart';
import 'package:resipal_core/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';
import 'package:resipal_core/domain/use_cases/get_applications.dart';
import 'package:resipal_core/domain/use_cases/get_memberships.dart';
import 'package:resipal_core/domain/use_cases/payments/get_payments.dart';
import 'package:resipal_core/domain/use_cases/properties/get_properties.dart';

class GetCommunity {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityEntity call(String communityId) {
    final model = _source.getById(communityId);

    if (model == null) {
      throw Exception('Community $communityId not found in cache. Ensure the stream is active.');
    }

    final applications = GetApplications().byCommunityId(communityId);
    final members = GetMemberships().byCommunityId(communityId);
    final payments = GetPayments().byCommunityId(communityId);
    final properties = GetProperties().byCommunityId(communityId);

    return CommunityEntity(
      id: model.id,
      name: model.name,
      location: model.location,
      description: model.description,

      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistry: PropertyRegistry(properties),
      directory: CommunityDirectoryEntity(applications, members),
    );
  }
}
