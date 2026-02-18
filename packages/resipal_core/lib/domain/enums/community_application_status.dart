enum CommunityApplicationStatus {
  approved,
  pendingReview,
  rejected,
  revoked;

  static CommunityApplicationStatus fromString(String value) {
    return switch (value) {
      'approved' => CommunityApplicationStatus.approved,
      'pending_review' => CommunityApplicationStatus.pendingReview,
      'rejected' => CommunityApplicationStatus.rejected,
      'revoked' => CommunityApplicationStatus.revoked,
      _ => throw UnimplementedError('Unknown UserCommunityStatus: $value'),
    };
  }
}
