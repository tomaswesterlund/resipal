enum CommunityApplicationStatus {
  approved,
  pendingReview,
  rejected;

  static CommunityApplicationStatus fromString(String value) {
    return switch (value) {
      'approved' => CommunityApplicationStatus.approved,
      'pending_review' => CommunityApplicationStatus.pendingReview,
      'rejected' => CommunityApplicationStatus.rejected,
      _ => throw UnimplementedError('Unknown UserCommunityStatus: $value'),
    };
  }
}
