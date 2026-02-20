class ErrorLogModel {
  final String id;
  final DateTime createdAt;
  final String? createdBy;
  final String errorMessage;
  final String? stackTrace;
  final String platform;
  final String appVersion;
  final String featureArea;
  final Map<String, dynamic>? metadata;

  ErrorLogModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.errorMessage,
    this.stackTrace,
    required this.platform,
    required this.appVersion,
    required this.featureArea,
    this.metadata,
  });

  factory ErrorLogModel.fromMap(Map<String, dynamic> json) {
    return ErrorLogModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      createdBy: json['created_by'],
      errorMessage: json['error_message'],
      stackTrace: json['stack_trace'],
      platform: json['platform'],
      appVersion: json['app_version'],
      featureArea: json['feature_area'],
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'error_message': errorMessage,
      'stack_trace': stackTrace,
      'platform': platform,
      'app_version': appVersion,
      'feature_area': featureArea,
      'metadata': metadata,
    };
  }
}
