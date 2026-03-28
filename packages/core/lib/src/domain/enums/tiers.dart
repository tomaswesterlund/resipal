enum Tiers {
  free,
  plan100,
  plan200,
  plan300;

  String toDisplayName() {
    switch (this) {
      case Tiers.free:
        return 'Plan 10 (Gratis)';
      case Tiers.plan100:
        return 'Plan 100 propiedades';
      case Tiers.plan200:
        return 'Plan 200 propiedades';
      case Tiers.plan300:
        return 'Plan 300 propiedades';
    }
  }

  static Tiers fromString(String tier) {
    switch (tier) {
      case 'free':
        return Tiers.free;
      case 'plan_100':
        return Tiers.plan100;
      case 'plan_200':
        return Tiers.plan200;
      case 'plan_300':
        return Tiers.plan300;
      default:
        throw ArgumentError('Invalid tier: $tier');
    }
  }
}
