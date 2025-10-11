class RewardRedemption extends Equatable {
  final String id;
  final String userId;
  final String rewardId;
  final DateTime redeemedAt;
  final String status; // redeemed, pending, cancelled

  const RewardRedemption({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.redeemedAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        rewardId,
        redeemedAt,
        status,
      ];
}