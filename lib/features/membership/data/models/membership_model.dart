import '../../domain/entities/membership.dart';

class MembershipModel extends Membership {
  const MembershipModel({
    required super.id,
    required super.userId,
    required super.businessId,
    required super.tierId,
    required super.issuedAt,
    super.expiresAt,
    required super.status,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      businessId: json['businessId'] as String,
      tierId: json['tierId'] as String,
      issuedAt: (json['issuedAt'] as String).isEmpty
          ? DateTime.now()
          : DateTime.parse(json['issuedAt'] as String),
      expiresAt: json['expiresAt'] != null && (json['expiresAt'] as String).isNotEmpty
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      status: json['status'] as String,
    );
  }

  factory MembershipModel.fromEntity(Membership membership) {
    return MembershipModel(
      id: membership.id,
      userId: membership.userId,
      businessId: membership.businessId,
      tierId: membership.tierId,
      issuedAt: membership.issuedAt,
      expiresAt: membership.expiresAt,
      status: membership.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessId': businessId,
      'tierId': tierId,
      'issuedAt': issuedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String() ?? '',
      'status': status,
    };
  }
}
