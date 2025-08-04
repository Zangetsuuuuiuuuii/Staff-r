class UserAuth {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserAuth({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isVerified: json['is_verified'] as bool,
      lastLogin: json['last_login'] != null 
          ? DateTime.parse(json['last_login'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'is_verified': isVerified,
      'last_login': lastLogin?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ProfessionalAuth {
  final String id;
  final bool isApproved;
  final String approvalStatus;
  final Map<String, dynamic> documents;
  final String backgroundCheckStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfessionalAuth({
    required this.id,
    required this.isApproved,
    required this.approvalStatus,
    required this.documents,
    required this.backgroundCheckStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfessionalAuth.fromJson(Map<String, dynamic> json) {
    return ProfessionalAuth(
      id: json['id'] as String,
      isApproved: json['is_approved'] as bool,
      approvalStatus: json['approval_status'] as String,
      documents: json['documents'] as Map<String, dynamic>,
      backgroundCheckStatus: json['background_check_status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_approved': isApproved,
      'approval_status': approvalStatus,
      'documents': documents,
      'background_check_status': backgroundCheckStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class BlockedRide {
  final String id;
  final String professionalId;
  final String clientId;
  final String? reason;
  final DateTime? blockedUntil;
  final bool isPermanent;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlockedRide({
    required this.id,
    required this.professionalId,
    required this.clientId,
    this.reason,
    this.blockedUntil,
    required this.isPermanent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlockedRide.fromJson(Map<String, dynamic> json) {
    return BlockedRide(
      id: json['id'] as String,
      professionalId: json['professional_id'] as String,
      clientId: json['client_id'] as String,
      reason: json['reason'] as String?,
      blockedUntil: json['blocked_until'] != null 
          ? DateTime.parse(json['blocked_until'] as String)
          : null,
      isPermanent: json['is_permanent'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'professional_id': professionalId,
      'client_id': clientId,
      'reason': reason,
      'blocked_until': blockedUntil?.toIso8601String(),
      'is_permanent': isPermanent,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 