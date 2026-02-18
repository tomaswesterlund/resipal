import 'package:get_it/get_it.dart';
import 'package:resipal_core/data/sources/community_data_source.dart';
import 'package:resipal_core/domain/entities/community/community_directory_entity.dart';
import 'package:resipal_core/domain/entities/community/community_entity.dart';
import 'package:resipal_core/domain/entities/payment/payment_ledger_entity.dart';
import 'package:resipal_core/domain/entities/property_registry.dart';
import 'package:resipal_core/domain/use_cases/get_community_applications.dart';
import 'package:resipal_core/domain/use_cases/get_community_members.dart';
import 'package:resipal_core/domain/use_cases/get_community_payments.dart';
import 'package:resipal_core/domain/use_cases/get_community_properties.dart';

class GetCommunity {
  final CommunityDataSource _source = GetIt.I<CommunityDataSource>();

  CommunityEntity call(String communityId) {
    final model = _source.getById(communityId);

    if (model == null) {
      throw Exception('Community $communityId not found in cache. Ensure the stream is active.');
    }

    final applications = GetCommunityApplications().byCommunityId(communityId);
    final members = GetCommunityMembers().call(communityId);
    final payments = GetCommunityPayments().call(communityId);
    final properties = GetCommunityProperties().call(communityId);

    return CommunityEntity(
      id: model.id,
      name: model.name,
      key: model.key,
      location: model.location,
      description: model.description,

      paymentLedger: PaymentLedgerEntity(payments),
      propertyRegistry: PropertyRegistry(properties),
      directory: CommunityDirectoryEntity(applications, members),
    );
  }
}
