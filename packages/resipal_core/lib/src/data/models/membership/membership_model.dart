// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MembershipModel {
  final String id;
  final String userId;
  final String communityId;
  final DateTime createdAt;
  final String createdBy;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  MembershipModel({
    required this.id,
    required this.userId,
    required this.communityId,
    required this.createdAt,
    required this.createdBy,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });

  MembershipModel copyWith({
    String? id,
    String? userId,
    String? communityId,
    DateTime? createdAt,
    String? createdBy,
    bool? isAdmin,
    bool? isResident,
    bool? isSecurity,
  }) {
    return MembershipModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      communityId: communityId ?? this.communityId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      isAdmin: isAdmin ?? this.isAdmin,
      isResident: isResident ?? this.isResident,
      isSecurity: isSecurity ?? this.isSecurity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'community_id': communityId,
      'created_at': createdAt.millisecondsSinceEpoch,
      'created_by': createdBy,
      'is_admin': isAdmin,
      'is_resident': isResident,
      'is_security': isSecurity,
    };
  }

  factory MembershipModel.fromMap(Map<String, dynamic> map) {
    return MembershipModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      communityId: map['community_id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
      isAdmin: map['is_admin'] as bool,
      isResident: map['is_resident'] as bool,
      isSecurity: map['is_security'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MembershipModel.fromJson(String source) => MembershipModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MembershipModel(id: $id, userId: $userId, communityId: $communityId, createdAt: $createdAt, createdBy: $createdBy, isAdmin: $isAdmin, isResident: $isResident, isSecurity: $isSecurity)';
  }

  @override
  bool operator ==(covariant MembershipModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userId == userId &&
      other.communityId == communityId &&
      other.createdAt == createdAt &&
      other.createdBy == createdBy &&
      other.isAdmin == isAdmin &&
      other.isResident == isResident &&
      other.isSecurity == isSecurity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      communityId.hashCode ^
      createdAt.hashCode ^
      createdBy.hashCode ^
      isAdmin.hashCode ^
      isResident.hashCode ^
      isSecurity.hashCode;
  }
}
