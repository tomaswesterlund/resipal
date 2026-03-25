class UpsertContractModel {
  final String communityId;
  final String name;
  final String period;
  final int amountInCents;
  final String? description;

  UpsertContractModel({
    required this.communityId,
    required this.name,
    required this.period,
    required this.amountInCents,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'community_id': communityId,
      'name': name,
      'period': period,
      'amount_in_cents': amountInCents,
      'description': description,
    };
  }
}
