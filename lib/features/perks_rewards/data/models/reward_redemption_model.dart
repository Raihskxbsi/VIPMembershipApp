import '../../domain/entities/reward_redemption.dart';

class RewardRedemptionModel extends RewardRedemption {
  const RewardRedemptionModel({
    required super.id,
    required super.userId,
    required super.rewardId,
    required super.redeemedAt,
    required super.status,
  });

  factory RewardRedemptionModel.fromJson(Map<String, dynamic> json) {
    return RewardRedemptionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      rewardId: json['rewardId'] as String,
      redeemedAt: DateTime.parse(json['redeemedAt'] as String),
      status: json['status'] as String,
    );
  }

  factory RewardRedemptionModel.fromEntity(RewardRedemption redemption) {
    return RewardRedemptionModel(
      id: redemption.id,
      userId: redemption.userId,
      rewardId: redemption.rewardId,
      redeemedAt: redemption.redeemedAt,
      status: redemption.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'rewardId': rewardId,
      'redeemedAt': redeemedAt.toIso8601String(),
      'status': status,
    };
  }
}
