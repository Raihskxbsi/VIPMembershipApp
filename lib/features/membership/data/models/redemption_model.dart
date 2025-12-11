import '../../domain/entities/redemption.dart';

class RedemptionModel extends Redemption {
  const RedemptionModel({
    required super.id,
    required super.userId,
    required super.businessId,
    super.perkId,
    required super.issuedAt,
    required super.expiresAt,
    required super.status,
    super.redeemedBy,
    super.redeemedAt,
  });

  factory RedemptionModel.fromJson(Map<String, dynamic> json) {
    return RedemptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      businessId: json['businessId'] as String,
      perkId: json['perkId'] as String?,
      issuedAt: (json['issuedAt'] as String).isEmpty
          ? DateTime.now()
          : DateTime.parse(json['issuedAt'] as String),
      expiresAt: (json['expiresAt'] as String).isEmpty
          ? DateTime.now().add(const Duration(days: 1))
          : DateTime.parse(json['expiresAt'] as String),
      status: json['status'] as String,
      redeemedBy: json['redeemedBy'] as String?,
      redeemedAt: json['redeemedAt'] != null && (json['redeemedAt'] as String).isNotEmpty
          ? DateTime.parse(json['redeemedAt'] as String)
          : null,
    );
  }

  factory RedemptionModel.fromEntity(Redemption redemption) {
    return RedemptionModel(
      id: redemption.id,
      userId: redemption.userId,
      businessId: redemption.businessId,
      perkId: redemption.perkId,
      issuedAt: redemption.issuedAt,
      expiresAt: redemption.expiresAt,
      status: redemption.status,
      redeemedBy: redemption.redeemedBy,
      redeemedAt: redemption.redeemedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessId': businessId,
      'perkId': perkId,
      'issuedAt': issuedAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'status': status,
      'redeemedBy': redeemedBy,
      'redeemedAt': redeemedAt?.toIso8601String() ?? '',
    };
  }
}
