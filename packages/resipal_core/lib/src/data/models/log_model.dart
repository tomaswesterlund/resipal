class LogModel { // Renamed from ErrorLogModel for general use
  final String id;
  final DateTime createdAt;
  final String? createdBy;
  final String level; // Added: 'INFO', 'ERROR', 'DEBUG', etc.
  final String message; // Renamed from errorMessage for generality
  final String? stackTrace;
  final String platform;
  final String appVersion;
  final String featureArea;
  final Map<String, dynamic>? metadata;

  LogModel({
    required this.id,
    required this.createdAt,
    this.createdBy,
    required this.level,
    required this.message,
    this.stackTrace,
    required this.platform,
    required this.appVersion,
    required this.featureArea,
    this.metadata,
  });

  factory LogModel.fromMap(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      level: json['level'] ?? 'ERROR', // Default to ERROR if null
      message: json['message'] ?? json['error_message'] ?? '', // Fallback for old schema
      stackTrace: json['stack_trace'],
      platform: json['platform'] ?? 'unknown',
      appVersion: json['app_version'] ?? 'unknown',
      featureArea: json['feature_area'] ?? 'unknown',
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'message': message,
      'stack_trace': stackTrace,
      'platform': platform,
      'app_version': appVersion,
      'feature_area': featureArea,
      'metadata': metadata,
      // 'id' and 'created_at' usually handled by Supabase defaults
    };
  }
}