import 'package:core/src/domain/enums/tiers.dart';
import 'package:equatable/equatable.dart';
import 'package:core/lib.dart';

class CommunityEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String? description;
  final Tiers tier;
  final List<ApplicationEntity> applications;
  final List<ContractEntity> contracts;
  final PaymentLedgerEntity ledger;
  final PropertyRegistry registry;
  final MemberDirectoryEntity directory;

  int get totalBalanceInCents {
    return ledger.totalApprovedPaymentBalanceInCents - registry.totalPaidAmountInCents;
  }

  bool get canRegisterNewProperty {
    switch (tier) {
      case Tiers.free:
        return registry.properties.length < 10;
      case Tiers.plan100:
        return registry.properties.length < 100;
      case Tiers.plan200:
        return registry.properties.length < 200;
      case Tiers.plan300:
        return registry.properties.length < 300;
    }
  }

  CommunityEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.tier,
    required this.applications,
    required this.contracts,
    required this.ledger,
    required this.registry,
    required this.directory,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    location,
    description,
    tier,
    applications,
    contracts,
    ledger,
    registry,
    directory,
  ];
}
