class UpsertApplicationModel {
  final String? id; // La Primary Key de la tabla 'applications'
  final String? userId;
  final String communityId;
  final String name;
  final String phoneNumber;
  final String? emergencyPhoneNumber;
  final String email;
  final String status;
  final String message;
  final bool isAdmin;
  final bool isResident;
  final bool isSecurity;

  UpsertApplicationModel({
    this.id, // Opcional: si se pasa, hace UPDATE; si es null, hace INSERT
    required this.userId,
    required this.communityId,
    required this.name,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.email,
    required this.status,
    required this.message,
    required this.isAdmin,
    required this.isResident,
    required this.isSecurity,
  });

  Map<String, dynamic> toMap() {
    return {
      // Clave para el Upsert: Si 'id' no está en el mapa, Postgres genera uno nuevo.
      if (id != null) 'id': id,

      'user_id': userId,
      'community_id': communityId,
      'name': name,
      'phone_number': phoneNumber,
      'emergency_phone_number': emergencyPhoneNumber,
      'email': email,
      'status': status,
      'message': message,
      'is_admin': isAdmin,
      'is_resident': isResident,
      'is_security': isSecurity,
    };
  }
}
